import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_payment_app/models/transaction.dart';
import 'package:simple_payment_app/providers/payment_provider.dart';
import 'package:simple_payment_app/widgets/transaction_list_tile.dart';

class AllTransactionsScreen extends StatefulWidget {
  static const routeName = '/all-transactions';
  @override
  _AllTransactionsScreenState createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("All transactions"),
    );
  }

  Widget _buildBody() {
    return Consumer<PaymentProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<List<Transaction>>(
          future: provider.getTransactions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final transactions = snapshot.data!;
              return Container(
                color: Colors.black26,
                child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: Column(
                        children: [
                          TransactionListTile(transaction: transactions[index]),
                          SizedBox(
                            height: 8,
                            child: Container(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ));
                    }),
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('Something went wrong'),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      },
    );
  }
}

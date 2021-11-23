import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_payment_app/models/transaction.dart';
import 'package:simple_payment_app/providers/payment_provider.dart';
import 'package:simple_payment_app/widgets/transaction_list_tile.dart';

class AllTransactionsScreen extends StatefulWidget {
  static const routeName = '/all-transactions';
  final String? userName;

  const AllTransactionsScreen({Key? key, this.userName}) : super(key: key);
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
    final title = isUserTransactions ? '${widget.userName} \'s transactions' : 'All transactions';
    return AppBar(
      title: Text(title),
    );
  }

  Widget _buildBody() {
    return Consumer<PaymentProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<List<Transaction>>(
          future: isUserTransactions ? provider.getUserTransactions(widget.userName!) : provider.getTransactions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final transactions = snapshot.data!;
              return Container(
                color: Colors.black12,
                child: transactions.length > 0
                    ? ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              child: Column(
                            children: [
                              TransactionListTile(
                                transaction: transactions[index],
                                inOut: isUserTransactions
                                    ? widget.userName!.toLowerCase() == transactions[index].personTo.toLowerCase()
                                    : null,
                              ),
                              SizedBox(
                                height: 8,
                                child: Container(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ));
                        })
                    : Container(
                        child: Center(
                          child: Text('No transactions yet'),
                        ),
                      ),
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

  bool get isUserTransactions => widget.userName != null;
}

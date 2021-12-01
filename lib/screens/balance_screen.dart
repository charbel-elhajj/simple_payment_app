import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_payment_app/providers/payment_provider.dart';

class BalanceScreen extends StatelessWidget {
  final String userName;

  const BalanceScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$userName \'s balance'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<PaymentProvider>(builder: (context, provider, _) {
      return FutureBuilder<double>(
        future: provider.getUserBalance(userName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final sign = snapshot.data! >= 0 ? '+' : '-';
            return Container(
              child: Center(
                child: Text(
                  '$sign ${snapshot.data!.abs()}',
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: snapshot.data! > 0 ? Colors.green : Colors.red,
                      ),
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
    });
  }
}

import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_payment_app/providers/auth_provider.dart';
import 'package:simple_payment_app/screens/all_transactions_screen.dart';
import 'package:simple_payment_app/screens/balance_screen.dart';
import 'package:simple_payment_app/screens/payment_input_screen.dart';
import 'package:simple_payment_app/screens/qr_code_scan_screen.dart';
import 'package:simple_payment_app/widgets/button.dart';

import 'payment_loader_screen.dart';

class UserActionsScreen extends StatefulWidget {
  static const routeName = '/user-actions';
  @override
  _UserActionsScreenState createState() => _UserActionsScreenState();
}

class _UserActionsScreenState extends State<UserActionsScreen> {
  var isEnabled = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("User Actions"),
    );
  }

  Widget _buildBody() {
    final authProvider = context.read<AuthProvider>();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Spacer(),
            Button(
              onPressHandler: () async {
                if (_formKey.currentState!.validate()) {
                  //QRCodeScanScreen
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRCodeScanScreen(),
                    ),
                  );
                  if (result != null) {
                    final personTo = json.decode(result)['person_to'] as String;
                    final amount = json.decode(result)['amount'];
                    final authProvider = context.read<AuthProvider>();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentLoaderScreen(
                          amount: amount,
                          personFrom: authProvider.keypair!.publicKey.toString(),
                          personTo: personTo,
                        ),
                      ),
                    );
                  }
                }
              },
              text: 'Pay',
            ),
            Spacer(),
            Button(
              onPressHandler: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentInputScreen(
                        publicKey: authProvider.keypair!.publicKey.toString(),
                        userName: authProvider.person!.email,
                      ),
                    ),
                  );
                }
              },
              text: 'Get paid',
            ),
            Spacer(),
            Button(
              onPressHandler: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BalanceScreen(
                        userName: authProvider.person!.email,
                      ),
                    ),
                  );
                }
              },
              text: 'Get Balance',
            ),
            Spacer(),
            Button(
              onPressHandler: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllTransactionsScreen(
                        userName: authProvider.person!.email,
                      ),
                    ),
                  );
                }
              },
              text: 'Get All transactions',
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_payment_app/providers/auth_provider.dart';
import 'package:simple_payment_app/providers/payment_provider.dart';
import 'package:provider/provider.dart';

import 'generic_confirmation_screen.dart';
import 'generic_error_screen.dart';

class PaymentLoaderScreen extends StatefulWidget {
  final String personFrom;
  final String personTo;

  final double amount;

  PaymentLoaderScreen({
    Key? key,
    required this.personFrom,
    required this.personTo,
    required this.amount,
  }) : super(key: key);

  @override
  _PaymentLoaderScreenState createState() => _PaymentLoaderScreenState();
}

class _PaymentLoaderScreenState extends State<PaymentLoaderScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    Future.delayed(Duration(seconds: 1), () async {
      final provider = context.read<PaymentProvider>();
      final authProvider = context.read<AuthProvider>();
      final transaction =
          await provider.createTransaction(widget.personFrom, widget.personTo, widget.amount, authProvider.keypair!);
      if (transaction != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GenericConfirmationScreen(
              callToActionText: 'Okay',
              callback: () {
                Navigator.pop(context);
              },
              mainText: '${widget.amount} has been sent',
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GenericErrorScreen(
              textAlign: TextAlign.center,
              callToActionText: 'Okay',
              callback: () {
                Navigator.pop(context);
              },
              mainText: 'An error occured while proccessing payment',
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Spacer(),
                CircularProgressIndicator.adaptive(),
                Text('Processing payment...'),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

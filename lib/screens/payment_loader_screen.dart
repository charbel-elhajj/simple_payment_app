import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

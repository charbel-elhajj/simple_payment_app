import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:simple_payment_app/providers/payment_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_payment_app/screens/user_actions_screens.dart';

import 'generic_confirmation_screen.dart';
import 'generic_error_screen.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({
    Key? key,
    required this.amount,
    required this.userName,
    required this.publicKey,
  }) : super(key: key);
  final double amount;
  final String userName;
  final String publicKey;
  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  PaymentProvider? provider;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        provider = context.read<PaymentProvider>();
      });

      try {
        final isConfirmed = await provider!.confirmPayment(
          userName: widget.userName,
          amount: widget.amount,
          timeoutDuration: Duration(minutes: 10),
          intervalDuration: Duration(seconds: 5),
        );
        if (isConfirmed != null) {
          isConfirmed ? _redirectToConfirmationScreen() : _redirectToErrorScreen('Payment timed out');
        }
      } on Exception catch (e) {
        print(e);
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    provider?.timer?.cancel();
    provider?.completer?.complete(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Center(
        child: _qrImage(context),
      ),
    );
  }

  void _redirectToConfirmationScreen() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GenericConfirmationScreen(
            mainText: 'Payment Succeeded\nYou received ${widget.amount}',
            callToActionText: 'Yay!',
            callback: () async {
              await Navigator.pushReplacementNamed(
                context,
                UserActionsScreen.routeName,
              );
            },
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }

  void _redirectToErrorScreen(String errorMessage) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GenericErrorScreen(
            mainText: 'Payment Failed',
            callToActionText: 'Oops!',
            callback: () async {
              await Navigator.pushReplacementNamed(
                context,
                UserActionsScreen.routeName,
              );
            },
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }

  Widget _qrImage(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Spacer(),
          QrImage(
            data: json.encode({
              'person_to': widget.publicKey,
              'amount': widget.amount,
            }),
            version: QrVersions.auto,
            size: MediaQuery.of(context).size.width * 0.75,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            '${widget.amount}',
            style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.green),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

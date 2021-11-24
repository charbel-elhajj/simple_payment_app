import 'package:flutter/material.dart';
import 'package:simple_payment_app/providers/payment_provider.dart';
import 'package:simple_payment_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'generic_confirmation_screen.dart';
import 'generic_error_screen.dart';

class IntegrityRoutingScreen extends StatefulWidget {
  static const routeName = '/integrity-routing';
  @override
  _IntegrityRoutingScreenState createState() => _IntegrityRoutingScreenState();
}

class _IntegrityRoutingScreenState extends State<IntegrityRoutingScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    // sleep(Duration(seconds: 3));
    Future.delayed(Duration.zero, () async {
      final provider = context.read<PaymentProvider>();
      final isValid = await provider.getIntegrity();
      if (isValid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GenericConfirmationScreen(
              callToActionText: 'Okay',
              callback: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              mainText: 'Transaction Integrity is validated!',
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GenericErrorScreen(
              callToActionText: 'Okay',
              callback: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              mainText: 'Transaction Integrity is not validated!',
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Checking integrity ..."),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

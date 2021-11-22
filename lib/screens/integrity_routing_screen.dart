import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_payment_app/screens/generic_confirmation_screen.dart';
import 'package:simple_payment_app/screens/home_screen.dart';

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
    Future.delayed(Duration.zero, () {
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

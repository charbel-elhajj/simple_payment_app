import 'package:flutter/material.dart';
import 'package:simple_payment_app/screens/all_transactions_screen.dart';
import 'package:simple_payment_app/screens/user_actions_screens.dart';
import 'package:simple_payment_app/widgets/button.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Welcome !"),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Spacer(),
          Button(
            onPressHandler: () {
              Navigator.pushNamed(context, AllTransactionsScreen.routeName);
            },
            text: 'Get all transactions',
          ),
          Spacer(),
          Button(
            onPressHandler: () {
              Navigator.pushNamed(context, UserActionsScreen.routeName);
            },
            text: 'User Actions',
          ),
          Spacer(),
          Button(
            onPressHandler: () {},
            text: 'Check Integrity',
          ),
          Spacer(),
        ],
      ),
    );
  }
}

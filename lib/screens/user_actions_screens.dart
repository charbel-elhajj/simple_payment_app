import 'package:flutter/material.dart';
import 'package:simple_payment_app/widgets/button.dart';
import 'package:simple_payment_app/widgets/text_input.dart';

class UserActionsScreen extends StatefulWidget {
  static const routeName = '/user-actions';
  @override
  _UserActionsScreenState createState() => _UserActionsScreenState();
}

class _UserActionsScreenState extends State<UserActionsScreen> {
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Spacer(),
          TextInput(
            placeholder: 'User Name',
          ),
          Spacer(),
          Button(
            onPressHandler: () {},
            text: 'Pay',
          ),
          Spacer(),
          Button(
            onPressHandler: () {},
            text: 'Get paid',
          ),
          Spacer(),
          Button(
            onPressHandler: () {},
            text: 'Get Balance',
          ),
          Spacer(),
        ],
      ),
    );
  }
}

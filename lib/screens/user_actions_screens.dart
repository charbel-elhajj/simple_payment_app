import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_payment_app/screens/all_transactions_screen.dart';
import 'package:simple_payment_app/screens/balance_screen.dart';
import 'package:simple_payment_app/screens/payment_input_screen.dart';
import 'package:simple_payment_app/widgets/button.dart';
import 'package:simple_payment_app/widgets/text_input.dart';

class UserActionsScreen extends StatefulWidget {
  static const routeName = '/user-actions';
  @override
  _UserActionsScreenState createState() => _UserActionsScreenState();
}

class _UserActionsScreenState extends State<UserActionsScreen> {
  final _controller = TextEditingController();
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

  void _unfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Spacer(),
            TextInput(
              placeholder: 'User Name',
              controller: _controller,
              onEditingComplete: _unfocusKeyboard,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a user name';
                }
                return null;
              },
            ),
            Spacer(),
            Button(
              onPressHandler: () {
                if (_formKey.currentState!.validate()) {}
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
                        userName: _controller.text,
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
                        userName: _controller.text,
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
                        userName: _controller.text,
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

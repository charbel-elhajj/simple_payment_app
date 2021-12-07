import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_payment_app/widgets/button.dart';
import 'package:simple_payment_app/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  var isEnabled = false;
  final _formKey = GlobalKey<FormState>();
  var _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Login"),
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
            SizedBox(
              height: 20,
            ),
            TextInput(
              placeholder: 'User Name',
              controller: _userController,
              onEditingComplete: _unfocusKeyboard,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a user name';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextInput(
              inputType: TextInputType.visiblePassword,
              placeholder: 'Password',
              obscureText: !_passwordVisible,
              controller: _passwordController,
              onEditingComplete: _unfocusKeyboard,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              icon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            Spacer(),
            Button(text: 'Login', onPressHandler: () {}),
            SizedBox(
              height: 30,
            ),
            Button(text: 'Sign up', onPressHandler: () {}),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

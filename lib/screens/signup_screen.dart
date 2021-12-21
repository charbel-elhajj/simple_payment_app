import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_payment_app/providers/auth_provider.dart';
import 'package:simple_payment_app/screens/home_screen.dart';
import 'package:simple_payment_app/widgets/button.dart';
import 'package:simple_payment_app/widgets/text_input.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var isEnabled = false;
  final _formKey = GlobalKey<FormState>();
  var _passwordVisible = false;
  var _confirmPasswordVisible = false;
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Sign up"),
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
            SizedBox(
              height: 30,
            ),
            TextInput(
              inputType: TextInputType.visiblePassword,
              placeholder: 'Confirm Password',
              obscureText: !_confirmPasswordVisible,
              controller: _confirmPasswordController,
              onEditingComplete: _unfocusKeyboard,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) return 'Confirmation is different than password';
                return null;
              },
              icon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
              ),
            ),
            Spacer(),
            if (_isLoading) CircularProgressIndicator(),
            if (!_isLoading)
              Button(
                text: 'Login',
                onPressHandler: () async {
                  if (_confirmPasswordController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      _userController.text.isEmpty) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Oops'),
                          content: Text('Please Fill all the fields'),
                          actions: [
                            Button(
                              text: 'OK',
                              onPressHandler: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (_confirmPasswordController.text != _passwordController.text) {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Oops'),
                            content: Text('Password and confirm password are not the same'),
                            actions: [
                              Button(
                                text: 'OK',
                                onPressHandler: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  } else {
                    final provider = context.read<AuthProvider>();
                    setState(() {
                      _isLoading = true;
                    });
                    final isSignedUp = await provider.signup(_userController.text, _passwordController.text);
                    setState(() {
                      _isLoading = false;
                    });
                    if (isSignedUp) {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    } else {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Couldn\'t register you'),
                            content: Text('Something went wrong'),
                            actions: [
                              Button(
                                text: 'OK',
                                onPressHandler: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

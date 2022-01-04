import 'package:crypton/crypton.dart';
import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_payment_app/providers/auth_provider.dart';
import 'package:simple_payment_app/screens/home_screen.dart';
import 'package:simple_payment_app/screens/signup_screen.dart';
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
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final keypair = RSAKeypair.fromRandom();
    String message = '10.0';
    String signature = keypair.privateKey.createSignature(message);
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    print(keypair.publicKey.toString());
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    print(signature);
    print(keypair.publicKey.verifySignature(message, signature));
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
            if (_isLoading) CircularProgressIndicator(),
            if (!_isLoading) ...[
              Button(
                text: 'Login',
                onPressHandler: () async {
                  if (_passwordController.text.isEmpty || _userController.text.isEmpty) {
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
                  } else {
                    final provider = context.read<AuthProvider>();
                    setState(() {
                      _isLoading = true;
                    });
                    final isSignedIn = await provider.signin(_userController.text, _passwordController.text);
                    setState(() {
                      _isLoading = false;
                    });
                    if (isSignedIn) {
                      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                    } else {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Couldn\'t sign you in'),
                            content: Text('Wrong email or password. Sorry...'),
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
                height: 30,
              ),
              Button(
                text: 'Sign up',
                onPressHandler: () {
                  print('test');
                  Navigator.pushNamed(context, SignupScreen.routeName);
                },
              ),
            ],
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

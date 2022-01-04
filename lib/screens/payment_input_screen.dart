import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_payment_app/screens/qr_code_screen.dart';
import 'package:simple_payment_app/widgets/button.dart';
import 'package:simple_payment_app/widgets/text_input.dart' as txt;

class PaymentInputScreen extends StatefulWidget {
  static const routeName = '/payment-input';
  final String publicKey;
  final String userName;

  const PaymentInputScreen({
    Key? key,
    required this.publicKey,
    required this.userName,
  }) : super(key: key);
  @override
  _PaymentInputScreenState createState() => _PaymentInputScreenState();
}

class _PaymentInputScreenState extends State<PaymentInputScreen> {
  final _controller = TextEditingController();
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
      title: Text("Payment Input"),
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
            Text(
              'Getting paid is nice!',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              'Let \'s generate a QR code',
              style: Theme.of(context).textTheme.headline4,
            ),
            Spacer(),
            txt.TextInput(
              onEditingComplete: _unfocusKeyboard,
              controller: _controller,
              inputType: TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              maxLength: 8,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.]?\d{0,2}')),
              ],
              placeholder: 'price',
              textAlign: TextAlign.end,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a user price';
                }
                return null;
              },
            ),
            Spacer(),
            Button(
              onPressHandler: () async {
                if (_formKey.currentState!.validate()) {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return QrCodeScreen(
                          amount: double.parse(_controller.text),
                          userName: widget.userName,
                          publicKey: widget.publicKey,
                        );
                      },
                    ),
                  );
                }
              },
              text: 'Generate QR Code',
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

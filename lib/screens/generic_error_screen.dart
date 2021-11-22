import 'package:flutter/material.dart';
import 'package:simple_payment_app/styles/spacings.dart';
import 'package:simple_payment_app/widgets/button.dart';
import 'package:simple_payment_app/widgets/check_circle_icon.dart';
import 'package:simple_payment_app/widgets/warning_icon.dart';

class GenericErrorScreen extends StatefulWidget {
  static const routeName = '/generic-confirmation-screen';
  final String mainText;
  final String callToActionText;
  final VoidCallback callback;
  final TextAlign? textAlign;

  GenericErrorScreen({
    required this.mainText,
    required this.callToActionText,
    required this.callback,
    this.textAlign,
  });

  @override
  _GenericErrorScreenState createState() => _GenericErrorScreenState();
}

class _GenericErrorScreenState extends State<GenericErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStack(),
          _buildBody(),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSpacing(5),
              vertical: getSpacing(4),
            ),
            child: Button(
              text: widget.callToActionText,
              onPressHandler: widget.callback,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Stack _buildStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).errorColor,
          ),
        ),
        Positioned(
          bottom: getSpacing(3),
          child: WarningIcon(
            color: Colors.white,
            size: getSpacing(10),
          ),
        ),
      ],
    );
  }

  Column _buildBody() {
    return Column(
      children: [
        SizedBox(height: getSpacing(4)),
        Text(
          widget.mainText,
          style: Theme.of(context).textTheme.headline2,
          textAlign: widget.textAlign,
        ),
      ],
    );
  }
}

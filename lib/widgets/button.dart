import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class Button extends StatefulWidget {
  final String text;
  final Function onPressHandler;
  final bool isDisabled;
  final bool hasBorders;
  final Color? backgroundColor;

  Button({
    required this.text,
    required this.onPressHandler,
    this.isDisabled = false,
    this.hasBorders = false,
    this.backgroundColor,
  });

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Color? currentColor(BuildContext context) {
    if (widget.backgroundColor != null) return widget.backgroundColor;
    if (!widget.isDisabled) return Theme.of(context).accentColor;

    return Theme.of(context).disabledColor;
  }

  BoxDecoration buildBorders() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(2.0),
      border: Border.all(
        color: widget.isDisabled ? greyColor : Colors.black,
        width: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      decoration: widget.hasBorders == true ? buildBorders() : null,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: currentColor(context),
        ),
        onPressed: () {
          if (!widget.isDisabled) {
            widget.onPressHandler();
          }
        },
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.headline3?.copyWith(
                color: widget.isDisabled ? greyColor : Colors.black,
              ),
        ),
      ),
    );
  }
}

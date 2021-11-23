import 'package:flutter/material.dart';

class WarningIcon extends StatelessWidget {
  final Color? color;
  final double? size;

  WarningIcon({
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.warning_rounded,
      color: color,
      size: size,
    );
  }
}

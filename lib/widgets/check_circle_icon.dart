import 'package:flutter/material.dart';

class CheckCircleIcon extends StatelessWidget {
  final Color color;
  final double? size;

  CheckCircleIcon({
    required this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check_circle,
      color: color,
      size: size,
    );
  }
}

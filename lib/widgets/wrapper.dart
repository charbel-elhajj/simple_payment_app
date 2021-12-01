import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/spacings.dart';

class Wrapper extends StatelessWidget {
  final Widget child;
  final bool hasGradient;
  final double horizontalPadding;

  Wrapper({
    required this.child,
    this.hasGradient = false,
    this.horizontalPadding = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getSpacing(4),
        horizontal: horizontalPadding,
      ),
      height: double.infinity,
      width: double.infinity,
      decoration: hasGradient == true
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  greenGradientStartColor,
                  greenGradientEndColor,
                ],
              ),
            )
          : null,
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

ThemeData theme = ThemeData(
  canvasColor: Colors.white,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    centerTitle: true,
    shadowColor: Colors.transparent,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: secondaryColor,
    unselectedItemColor: greyColor,
    selectedLabelStyle: headline5Style,
    unselectedLabelStyle: headline5Style,
  ),
  textTheme: TextTheme(
    headline1: headline1Style,
    headline2: headline2Style,
    headline3: headline3Style,
    headline4: headline4Style,
    headline5: headline5Style,
    bodyText1: bodyStyle,
    caption: linkStyle,
  ),
  accentColor: primaryColor,
  primaryColor: secondaryColor,
  focusColor: secondaryColor,
  errorColor: errorColor,
  backgroundColor: Colors.white,
  disabledColor: lightGreyColor,
  inputDecorationTheme: InputDecorationTheme(
    errorStyle: TextStyle(fontSize: 16),
    errorBorder: buildOutlineInputBorder(errorColor),
    focusedErrorBorder: buildOutlineInputBorder(errorColor),
    focusedBorder: buildOutlineInputBorder(secondaryColor),
    border: buildOutlineInputBorder(greyColor).copyWith(
      borderRadius: BorderRadius.circular(3.0),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

OutlineInputBorder buildOutlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderSide: buildBorderSide(color),
  );
}

BorderSide buildBorderSide(Color color) {
  return BorderSide(
    color: color,
  );
}

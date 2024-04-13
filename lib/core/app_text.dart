import 'package:flutter/material.dart';

class AppText {
  static TextStyle textStyle({Color? color, double? size}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: color,
      fontSize: size,
      letterSpacing: -0.3,
    );
  }
}

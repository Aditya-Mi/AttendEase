import 'package:attendease/core/app_colors.dart';
import 'package:flutter/material.dart';

class MyAppTypography {
  static TextStyle textStyle({Color? color, double? size}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: color,
      fontSize: size,
      letterSpacing: -0.3,
    );
  }

  static TextStyle body1 = MyAppTypography.textStyle(
    color: AppColors.text100,
    size: 12.94,
  );
  static TextStyle body2 = MyAppTypography.textStyle(
    color: AppColors.text100,
    size: 16.18,
  );
  static TextStyle body3 = MyAppTypography.textStyle(
    color: AppColors.text200,
    size: 12.94,
  );
  static TextStyle body4 = MyAppTypography.textStyle(
    color: AppColors.text200,
    size: 16.18,
  );
  static TextStyle body5 = MyAppTypography.textStyle(
    color: AppColors.text100,
    size: 16.38,
  );
}

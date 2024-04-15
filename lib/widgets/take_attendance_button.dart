import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_shadow.dart';
import 'package:attendease/core/app_text.dart';
import 'package:flutter/material.dart';

class TakeAttendanceButton extends StatelessWidget {
  const TakeAttendanceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primary100,
        boxShadow: [
          MyAppBoxShadow.myCustomBoxShadow(Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Text(
        'Take Attendance',
        style: MyAppTypography.body3.copyWith(color: AppColors.bg100),
      ),
    );
  }
}

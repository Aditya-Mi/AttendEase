import 'package:attendease/core/app_colors.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  const ProgressBar({super.key, required this.progress});

  double getWidth() {
    return (146 / 100) * 58;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 15,
          width: 146,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.bg100,
            border: Border.all(color: AppColors.text200),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 15,
            width: getWidth(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primary200,
            ),
          ),
        ),
      ],
    );
  }
}

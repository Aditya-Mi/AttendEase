import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:flutter/material.dart';

class SemesterItem extends StatelessWidget {
  final int semNo;
  const SemesterItem({super.key, required this.semNo});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.bg200,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Text(
        'Sem $semNo',
        style: AppText.textStyle(
          color: AppColors.text100,
          size: 20,
        ),
      ),
    );
  }
}

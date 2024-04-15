import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class TitleItem extends StatelessWidget {
  final String title;
  const TitleItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
            child: CustomDivider(
              color: AppColors.primary200,
              isVertical: true,
              width: 2,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style: MyAppTypography.body1.copyWith(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:attendease/core/app_colors.dart';
import 'package:flutter/material.dart';

class FunctionButton extends StatelessWidget {
  final IconData icon;
  final Widget text;
  final Function() function;
  const FunctionButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          alignment: Alignment.center,
          onPressed: function,
          icon: Icon(
            icon,
            color: AppColors.bg100,
          ),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primary100,
            fixedSize: const Size(61, 51),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        text,
      ],
    );
  }
}

import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final VoidCallback function;
  final IconData icon;
  final String title;
  final String subTitle;
  const SettingsItem(
      {super.key,
      required this.function,
      required this.icon,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffF4F4F4),
            ),
          ),
        ),
        child: ListTile(
          visualDensity: VisualDensity.compact,
          minVerticalPadding: 0,
          dense: false,
          leading: Icon(
            icon,
            size: 32,
            color: AppColors.text200,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
          title: Text(title),
          titleTextStyle:
              AppText.textStyle(size: 16.18, color: AppColors.text100),
          subtitleTextStyle: AppText.textStyle(
            size: 12.94,
            color: AppColors.text100.withOpacity(0.5),
          ),
          subtitle: Text(subTitle),
        ),
      ),
    );
  }
}

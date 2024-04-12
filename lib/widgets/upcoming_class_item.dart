import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/widgets/circle.dart';
import 'package:flutter/material.dart';

class UpcomingClassItem extends StatelessWidget {
  final String subjectName;
  final String classType;
  final String timings;
  final String roomNumber;
  final String section;
  const UpcomingClassItem(
      {super.key,
      required this.subjectName,
      required this.classType,
      required this.timings,
      required this.roomNumber,
      required this.section});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Cricle(
            size: 8,
            color: AppColors.primary200,
          ),
        ),
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 7),
            decoration: BoxDecoration(
              color: AppColors.bg100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: subjectName,
                        style: AppText.textStyle(
                          color: AppColors.text100,
                          size: 16.38,
                        ),
                        children: [
                          TextSpan(
                            text: ' ($classType)',
                            style: AppText.textStyle(
                              color: AppColors.text200,
                              size: 12.94,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      timings,
                      style: AppText.textStyle(
                        color: AppColors.text200,
                        size: 12.94,
                      ),
                    ),
                    Text(
                      'Room Number $roomNumber',
                      style: AppText.textStyle(
                        color: AppColors.text200,
                        size: 12.94,
                      ),
                    ),
                  ],
                ),
                Text(
                  section,
                  style: AppText.textStyle(
                    color: AppColors.text100,
                    size: 16.38,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

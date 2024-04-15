import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/core/widgets/circle.dart';
import 'package:attendease/models/class.dart';
import 'package:flutter/material.dart';

class UpcomingClassItem extends StatelessWidget {
  final Class kClass;
  const UpcomingClassItem({
    super.key,
    required this.kClass,
  });

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
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: kClass.topic,
                          style: MyAppTypography.body5,
                          children: [
                            TextSpan(
                              text: ' (${kClass.type})',
                              style: MyAppTypography.body3,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${convert24HourTo12Hour(kClass.startTime)} - ${convert24HourTo12Hour(kClass.endTime)}',
                        style: MyAppTypography.body3,
                      ),
                      Text(
                        'Room Number ${kClass.roomNo}',
                        style: MyAppTypography.body3,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    kClass.section,
                    style: MyAppTypography.body5,
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

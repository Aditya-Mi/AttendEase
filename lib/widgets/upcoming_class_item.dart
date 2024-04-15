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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 3,
                            fit: FlexFit.loose,
                            child: Text(
                              kClass.topic,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: MyAppTypography.body5,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              ' (${kClass.type})',
                              style: MyAppTypography.body3,
                            ),
                          )
                        ],
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
                const SizedBox(
                  width: 10,
                ),
                Text(
                  kClass.section,
                  style: MyAppTypography.body5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_shadow.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/core/widgets/custom_divider.dart';
import 'package:attendease/models/class.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineItem extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isBreak;
  final String startTime;
  final String endTime;
  final Class? kClass;
  const TimeLineItem(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isBreak,
      this.kClass,
      required this.endTime,
      required this.startTime});

  Widget getItem() {
    if (isFirst) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 25),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.bg200,
          boxShadow: [
            MyAppBoxShadow.myCustomBoxShadow(Colors.black.withOpacity(0.05)),
          ],
        ),
        child: Text(
          'Start',
          style: MyAppTypography.body5,
        ),
      );
    }
    if (isLast) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 25),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.bg200,
          boxShadow: [
            MyAppBoxShadow.myCustomBoxShadow(Colors.black.withOpacity(0.05)),
          ],
        ),
        child: Text(
          'Finish',
          style: MyAppTypography.body5,
        ),
      );
    }
    if (isBreak) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 25),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.bg200,
          boxShadow: [
            MyAppBoxShadow.myCustomBoxShadow(Colors.black.withOpacity(0.05)),
          ],
        ),
        child: Text(
          'Break',
          style: MyAppTypography.body5,
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      padding: const EdgeInsets.only(top: 5, left: 8, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.bg200,
        boxShadow: [
          MyAppBoxShadow.myCustomBoxShadow(Colors.black.withOpacity(0.05)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            kClass!.topic,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: MyAppTypography.body5,
          ),
          Text(
            '( ${kClass!.type} )',
            style: MyAppTypography.body3,
          ),
          Text(
            '${kClass!.semester}th Semester',
            style: MyAppTypography.body3,
          ),
          Text(
            'Room Number ${kClass!.roomNo}',
            style: MyAppTypography.body3,
          ),
          Text(
            kClass!.section,
            style: MyAppTypography.body3,
          ),
        ],
      ),
    );
  }

  String getTime() {
    if (isFirst) {
      return "${convert24HourTo12Hour(startTime)} - ${convert24HourTo12Hour(startTime)}";
    }
    if (isBreak) {
      return "12:50 PM - 1:30 PM";
    }
    if (isLast) {
      return "${convert24HourTo12Hour(endTime)} - ${convert24HourTo12Hour(endTime)}";
    }
    return '${convert24HourTo12Hour(kClass!.startTime)} - ${convert24HourTo12Hour(kClass!.endTime)}';
  }

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: const IndicatorStyle(
        padding: EdgeInsets.symmetric(vertical: 18),
        color: AppColors.primary200,
        width: 13,
      ),
      beforeLineStyle: const LineStyle(color: Color(0xff9E9E9E), thickness: 1),
      afterLineStyle: const LineStyle(color: Color(0xff9E9E9E), thickness: 1),
      endChild: Padding(
        padding: const EdgeInsets.only(left: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Text(
                getTime(),
                style: MyAppTypography.body3,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              flex: 5,
              child: Column(
                children: [
                  const CustomDivider(
                    color: Color(0xffF1F1F1),
                    width: 0.5,
                  ),
                  Expanded(child: getItem()),
                  const CustomDivider(
                    color: Color(0xffF1F1F1),
                    width: 0.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

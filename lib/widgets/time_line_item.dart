import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineItem extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isBreak;
  const TimeLineItem(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isBreak});

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
            BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Text(
          'Start',
          style: AppText.textStyle(
            color: AppColors.text100,
            size: 16.38,
          ),
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
            BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Text(
          'Break',
          style: AppText.textStyle(
            color: AppColors.text100,
            size: 16.38,
          ),
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
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Microwave Engineering',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppText.textStyle(
              color: AppColors.text100,
              size: 16.38,
            ),
          ),
          Text(
            '( Theory )',
            style: AppText.textStyle(
              color: AppColors.text200,
              size: 12.94,
            ),
          ),
          Text(
            '8th Semester',
            style: AppText.textStyle(
              color: AppColors.text200,
              size: 12.94,
            ),
          ),
          Text(
            'Room Number 405',
            style: AppText.textStyle(
              color: AppColors.text200,
              size: 12.94,
            ),
          ),
          Text(
            '8E7',
            style: AppText.textStyle(
              color: AppColors.text200,
              size: 12.94,
            ),
          ),
        ],
      ),
    );
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
            Text(
              '12:45 pm - 01:45 pm',
              style: AppText.textStyle(
                color: AppColors.text200,
                size: 12.94,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
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

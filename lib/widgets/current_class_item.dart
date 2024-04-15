import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_shadow.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/core/widgets/circle.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/screens/take_attendance_screen.dart';
import 'package:flutter/material.dart';

class CurrentClassItem extends StatelessWidget {
  final Class kClass;
  const CurrentClassItem({
    super.key,
    required this.kClass,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.bg200,
        boxShadow: [
          MyAppBoxShadow.myCustomBoxShadow(Colors.black.withOpacity(0.15)),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      kClass.topic,
                      style: MyAppTypography.body2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    ' (${kClass.type})',
                    style: MyAppTypography.body3,
                  ),
                  const Spacer(),
                  Text(
                    kClass.section,
                    style: MyAppTypography.body5,
                  ),
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
              const Spacer(),
              Row(
                children: [
                  const Cricle(
                    size: 7,
                    color: Color(0xffC44545),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    'LIVE',
                    style: MyAppTypography.textStyle(
                        color: const Color(0xffC44545), size: 10),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TakeAttendanceScreen(
                    kClass: kClass,
                  ),
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary100,
                  boxShadow: [
                    MyAppBoxShadow.myCustomBoxShadow(
                        Colors.black.withOpacity(0.08)),
                  ],
                ),
                child: Text(
                  'Take Attendance',
                  style: MyAppTypography.body2.copyWith(color: AppColors.bg100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

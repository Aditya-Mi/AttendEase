import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_shadow.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/core/widgets/progress_bar.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/models/class_record.dart';
import 'package:flutter/material.dart';

class AttendanceItem extends StatelessWidget {
  final Class kClass;
  final ClassRecord classRecord;
  final double attendance;
  const AttendanceItem({
    super.key,
    required this.kClass,
    required this.classRecord,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.bg100,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          MyAppBoxShadow.myCustomBoxShadow(Colors.black.withOpacity(0.10)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  kClass.topic,
                  style: MyAppTypography.body5,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                kClass.section,
                style: MyAppTypography.body5,
              ),
            ],
          ),
          Text(
            '(${kClass.type})',
            style: MyAppTypography.body3,
          ),
          const Spacer(),
          Text(
            '${convert24HourTo12Hour(kClass.startTime)} - ${convert24HourTo12Hour(kClass.endTime)}',
            style: MyAppTypography.body3,
          ),
          Text(
            'Room Number ${kClass.roomNo}',
            style: MyAppTypography.body3,
          ),
          Row(
            children: [
              ProgressBar(
                progress: attendance,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '$attendance% Attendance',
                style: MyAppTypography.body3,
              )
            ],
          )
        ],
      ),
    );
  }
}

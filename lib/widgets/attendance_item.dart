import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_shadow.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class AttendanceItem extends StatelessWidget {
  final String subjectName;
  final String classType;
  final String timings;
  final String roomNumber;
  final String section;
  final String attendance;
  const AttendanceItem(
      {super.key,
      required this.subjectName,
      required this.classType,
      required this.timings,
      required this.roomNumber,
      required this.section,
      required this.attendance});

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
                  subjectName,
                  style: MyAppTypography.body5,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                section,
                style: MyAppTypography.body5,
              ),
            ],
          ),
          Text(
            '($classType)',
            style: MyAppTypography.body3,
          ),
          const Spacer(),
          Text(
            timings,
            style: MyAppTypography.body3,
          ),
          Text(
            'Room Number $roomNumber',
            style: MyAppTypography.body3,
          ),
          Row(
            children: [
              ProgressBar(
                progress: double.parse(attendance),
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

import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class TodayAttendanceItem extends StatelessWidget {
  final String subjectName;
  final String classType;
  final String timings;
  final String roomNumber;
  final String section;
  final String attendance;
  const TodayAttendanceItem(
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
      width: 300,
      decoration: BoxDecoration(
        color: AppColors.bg100,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
          ),
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
                  style: AppText.textStyle(
                    color: AppColors.text100,
                    size: 16.38,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 20,
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
          Text(
            '($classType)',
            style: AppText.textStyle(
              color: AppColors.text200,
              size: 12.94,
            ),
          ),
          const Spacer(),
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
                style: AppText.textStyle(
                  color: AppColors.text200,
                  size: 12.94,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

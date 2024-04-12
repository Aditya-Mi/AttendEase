import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/widgets/circle.dart';
import 'package:attendease/screens/take_attendance_screen.dart';
import 'package:flutter/material.dart';

class CurrentClassItem extends StatelessWidget {
  final String subjectName;
  final String classType;
  final String timings;
  final String roomNumber;
  final String section;
  const CurrentClassItem(
      {super.key,
      required this.subjectName,
      required this.classType,
      required this.timings,
      required this.roomNumber,
      required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.bg200,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.15),
          ),
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
                      subjectName,
                      style: AppText.textStyle(
                        color: AppColors.text100,
                        size: 16.38,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    ' ($classType)',
                    style: AppText.textStyle(
                      color: AppColors.text200,
                      size: 12.94,
                    ),
                  ),
                  const Spacer(),
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
                    style: AppText.textStyle(
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
                  builder: (context) => const TakeAttendanceScreen(),
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary100,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ],
                ),
                child: Text(
                  'Take Attendance',
                  style: AppText.textStyle(
                    color: Colors.white,
                    size: 16.18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

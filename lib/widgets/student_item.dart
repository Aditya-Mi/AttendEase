import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/core/widgets/custom_divider.dart';
import 'package:attendease/models/class_record.dart';
import 'package:attendease/models/filters.dart';
import 'package:flutter/material.dart';

class StudentItem extends StatelessWidget {
  final Student student;
  final Filters filters;
  final double attendance;
  const StudentItem({
    super.key,
    required this.student,
    required this.filters,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    final year = mapSemesterToYear(filters.semester!);
    return Container(
      height: 106,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.text100),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: AppColors.bg200,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 106,
            height: 106,
            child: Image.network(
              'https://images.unsplash.com/photo-1712309910201-c1bc5d70744e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${student.firstName} ${student.lastName}',
                style: MyAppTypography.body2,
              ),
              Text(
                generateRandomNumber(),
                style: MyAppTypography.body1,
              ),
              const Spacer(),
              Text(
                'Year : $year${mapInputToValue(year)} Year',
                style: MyAppTypography.body3,
              ),
              Text(
                'Branch : ${filters.branch}',
                style: MyAppTypography.body3,
              ),
              Text(
                'Section : ${filters.section}',
                style: MyAppTypography.body3,
              ),
            ],
          ),
          const SizedBox(
            width: 14,
          ),
          const SizedBox(
            height: 17,
            child: CustomDivider(
              color: AppColors.text200,
              isVertical: true,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$attendance%',
                    style: MyAppTypography.body2,
                  ),
                  Text(
                    'Subject Attendance',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: MyAppTypography.body3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

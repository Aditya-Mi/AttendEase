import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_shadow.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/models/single_class_record.dart';
import 'package:attendease/models/student_attendance.dart';
import 'package:flutter/material.dart';

class TakeAttendanceItem extends StatefulWidget {
  final Student student;
  final int noOfClasses;
  final StudentAttendance studentAttendance;
  final Function(AttendanceStatus) onAttendanceChanged;
  const TakeAttendanceItem({
    super.key,
    required this.student,
    required this.noOfClasses,
    required this.studentAttendance,
    required this.onAttendanceChanged,
  });

  @override
  State<TakeAttendanceItem> createState() => _TakeAttendanceItemState();
}

class _TakeAttendanceItemState extends State<TakeAttendanceItem> {
  double getWidth(bool isPresentButton, double width) {
    if (isPresentButton) {
      if (widget.studentAttendance.attendanceStatus ==
          AttendanceStatus.Present) {
        return (width - 4 * 21 - 7) * 0.75;
      } else if (widget.studentAttendance.attendanceStatus ==
          AttendanceStatus.Absent) {
        return (width - 4 * 21 - 7) * 0.25;
      } else {
        return (width - 4 * 21 - 20) * 0.5;
      }
    } else {
      if (widget.studentAttendance.attendanceStatus ==
          AttendanceStatus.Absent) {
        return (width - 4 * 21 - 7) * 0.75;
      } else if (widget.studentAttendance.attendanceStatus ==
          AttendanceStatus.Present) {
        return (width - 4 * 21 - 7) * 0.25;
      } else {
        return (width - 4 * 21 - 20) * 0.5;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final attendancePercent =
        (widget.student.classAttended / widget.noOfClasses) * 100;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.text100,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.bg300,
                radius: 22.5,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.student.firstName} ${widget.student.lastName}',
                      style: MyAppTypography.body2,
                    ),
                    Text(
                      generateRandomNumber(),
                      style: MyAppTypography.body3.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$attendancePercent%',
                      style: MyAppTypography.body3,
                    ),
                    Text(
                      'Subject Attendance',
                      textAlign: TextAlign.center,
                      style: MyAppTypography.body3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.studentAttendance.attendanceStatus ==
                        AttendanceStatus.Present) {
                      return;
                    }
                    if (widget.studentAttendance.attendanceStatus ==
                        AttendanceStatus.Absent) {
                      widget.onAttendanceChanged(AttendanceStatus.None);
                    } else {
                      widget.onAttendanceChanged(AttendanceStatus.Present);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  width: getWidth(true, width),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: widget.studentAttendance.attendanceStatus ==
                            AttendanceStatus.Absent
                        ? AppColors.undoButtonColor
                        : AppColors.primary100,
                    boxShadow: [
                      MyAppBoxShadow.myCustomBoxShadow(
                          Colors.black.withOpacity(0.10)),
                    ],
                  ),
                  child: Text(
                    widget.studentAttendance.attendanceStatus ==
                            AttendanceStatus.Absent
                        ? 'Undo'
                        : 'Present',
                    style:
                        MyAppTypography.body3.copyWith(color: AppColors.bg100),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: widget.studentAttendance.attendanceStatus ==
                            AttendanceStatus.Absent ||
                        widget.studentAttendance.attendanceStatus ==
                            AttendanceStatus.Present
                    ? 7
                    : 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.studentAttendance.attendanceStatus ==
                        AttendanceStatus.Absent) {
                      return;
                    }
                    if (widget.studentAttendance.attendanceStatus ==
                        AttendanceStatus.Present) {
                      widget.onAttendanceChanged(AttendanceStatus.None);
                    } else {
                      widget.onAttendanceChanged(AttendanceStatus.Absent);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  width: getWidth(false, width),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: widget.studentAttendance.attendanceStatus ==
                            AttendanceStatus.Present
                        ? AppColors.undoButtonColor
                        : AppColors.absentButtonColor,
                    boxShadow: [
                      MyAppBoxShadow.myCustomBoxShadow(
                          Colors.black.withOpacity(0.10)),
                    ],
                  ),
                  child: Text(
                    widget.studentAttendance.attendanceStatus ==
                            AttendanceStatus.Present
                        ? 'Undo'
                        : 'Absent',
                    style:
                        MyAppTypography.body3.copyWith(color: AppColors.bg100),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_shadow.dart';
import 'package:attendease/core/app_text.dart';
import 'package:flutter/material.dart';

class TakeAttendanceItem extends StatefulWidget {
  const TakeAttendanceItem({super.key});

  @override
  State<TakeAttendanceItem> createState() => _TakeAttendanceItemState();
}

class _TakeAttendanceItemState extends State<TakeAttendanceItem> {
  bool _isAbsent = false;
  bool _isPresent = false;

  double getWidth(bool isPresentButton, double width) {
    if (isPresentButton) {
      if (_isPresent) {
        return (width - 4 * 21 - 7) * 0.75;
      } else if (_isAbsent) {
        return (width - 4 * 21 - 7) * 0.25;
      } else {
        return (width - 4 * 21 - 20) * 0.5;
      }
    } else {
      if (_isAbsent) {
        return (width - 4 * 21 - 7) * 0.75;
      } else if (_isPresent) {
        return (width - 4 * 21 - 7) * 0.25;
      } else {
        return (width - 4 * 21 - 20) * 0.5;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      'Shivang Singh',
                      style: MyAppTypography.body2,
                    ),
                    Text(
                      '13214802820',
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
                      '48%',
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
                    if (_isPresent) {
                      return;
                    }
                    if (_isAbsent) {
                      _isAbsent = !_isAbsent;
                    } else {
                      _isPresent = !_isPresent;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  width: getWidth(true, width),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _isAbsent
                        ? AppColors.undoButtonColor
                        : AppColors.primary100,
                    boxShadow: [
                      MyAppBoxShadow.myCustomBoxShadow(
                          Colors.black.withOpacity(0.10)),
                    ],
                  ),
                  child: Text(
                    _isAbsent ? 'Undo' : 'Present',
                    style:
                        MyAppTypography.body3.copyWith(color: AppColors.bg100),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _isAbsent || _isPresent ? 7 : 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isAbsent) {
                      return;
                    }
                    if (_isPresent) {
                      _isPresent = !_isPresent;
                    } else {
                      _isAbsent = !_isAbsent;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  width: getWidth(false, width),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _isPresent
                        ? AppColors.undoButtonColor
                        : AppColors.absentButtonColor,
                    boxShadow: [
                      MyAppBoxShadow.myCustomBoxShadow(
                          Colors.black.withOpacity(0.10)),
                    ],
                  ),
                  child: Text(
                    _isPresent ? 'Undo' : 'Absent',
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

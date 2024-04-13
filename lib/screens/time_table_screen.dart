import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/widgets/time_line_item.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum WeekDays { mon, tue, wed, thu, fri, sat }

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  WeekDays _selectedSegment = WeekDays.mon;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Time Table'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
              child: CustomSlidingSegmentedControl(
                  padding: 10,
                  initialValue: WeekDays.mon,
                  innerPadding: const EdgeInsets.all(0),
                  isStretch: true,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.bg200,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ]),
                  thumbDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.primary100),
                  onValueChanged: (WeekDays value) {
                    setState(() {
                      _selectedSegment = value;
                    });
                  },
                  children: <WeekDays, Widget>{
                    WeekDays.mon: Text(
                      'Mon',
                      style: AppText.textStyle(
                        size: 15,
                        color: _selectedSegment == WeekDays.mon
                            ? Colors.white
                            : AppColors.text200,
                      ),
                    ),
                    WeekDays.tue: Text(
                      'Tue',
                      style: AppText.textStyle(
                        size: 15,
                        color: _selectedSegment == WeekDays.tue
                            ? Colors.white
                            : AppColors.text200,
                      ),
                    ),
                    WeekDays.wed: Text(
                      'Wed',
                      style: AppText.textStyle(
                        size: 15,
                        color: _selectedSegment == WeekDays.wed
                            ? Colors.white
                            : AppColors.text200,
                      ),
                    ),
                    WeekDays.thu: Text(
                      'Thu',
                      style: AppText.textStyle(
                        size: 15,
                        color: _selectedSegment == WeekDays.thu
                            ? Colors.white
                            : AppColors.text200,
                      ),
                    ),
                    WeekDays.fri: Text(
                      'Fri',
                      style: AppText.textStyle(
                        size: 15,
                        color: _selectedSegment == WeekDays.fri
                            ? Colors.white
                            : AppColors.text200,
                      ),
                    ),
                    WeekDays.sat: Text(
                      'Sat',
                      style: AppText.textStyle(
                        size: 15,
                        color: _selectedSegment == WeekDays.sat
                            ? Colors.white
                            : AppColors.text200,
                      ),
                    )
                  }),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  TimeLineItem(isFirst: true, isLast: false, isBreak: false),
                  TimeLineItem(isFirst: false, isLast: false, isBreak: false),
                  TimeLineItem(isFirst: false, isLast: false, isBreak: false),
                  TimeLineItem(isFirst: false, isLast: false, isBreak: true),
                  TimeLineItem(isFirst: false, isLast: false, isBreak: false),
                  TimeLineItem(isFirst: false, isLast: false, isBreak: false),
                  TimeLineItem(isFirst: false, isLast: true, isBreak: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/widgets/time_line_item.dart';
import 'package:flutter/material.dart';

class TimeTableItem extends StatelessWidget {
  final List<Class> classes;
  final String day;
  const TimeTableItem({super.key, required this.classes, required this.day});

  @override
  Widget build(BuildContext context) {
    List<Class> classesOnCurrentDay = classes.where((classData) {
      return classData.dayOfWeek.contains(day);
    }).toList();
    classesOnCurrentDay.sort((a, b) {
      DateTime startTimeA = parseTime(a.startTime);
      DateTime startTimeB = parseTime(b.startTime);
      return startTimeA.compareTo(startTimeB);
    });
    String startTime = '';
    String endTime = '';
    List<Class> classesBeforeBreak = [];
    List<Class> classesAfterBreak = [];
    if (classesOnCurrentDay.isNotEmpty) {
      startTime = classesOnCurrentDay.first.startTime;
      endTime = classesOnCurrentDay.last.endTime;

      for (Class kClass in classesOnCurrentDay) {
        // Get the end time of the class
        String endTime = kClass.endTime;

        // Compare the end time with the break time
        if (isBefore(endTime, "12:50") || isEqual(endTime, "12:50")) {
          // If the class ends before the break time
          classesBeforeBreak.add(kClass);
        } else if (isAfter(endTime, "13:30")) {
          // If the class starts after the break time
          classesAfterBreak.add(kClass);
        }
      }
    }
    return classesOnCurrentDay.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/empty.png'),
                Text(
                  'No classes on $day',
                  style: MyAppTypography.body2.copyWith(
                    color: const Color(0xffCCCCCC),
                  ),
                )
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: classesBeforeBreak.length +
                classesAfterBreak.length +
                3, // +3 for the first, break, and finish items
            itemBuilder: (context, index) {
              if (index == 0) {
                // Render first widget
                return TimeLineItem(
                  isFirst: true,
                  isBreak: false,
                  isLast: false,
                  endTime: endTime,
                  startTime: startTime,
                );
              } else if (index < classesBeforeBreak.length + 1) {
                // Render classes before break
                return TimeLineItem(
                  isFirst: false,
                  isLast: false,
                  isBreak: false,
                  kClass: classesBeforeBreak[
                      index - 1], // Subtract 1 to account for the first widget
                  startTime: startTime,
                  endTime:
                      endTime, // Assuming last time is always 12:50 before the break
                );
              } else if (index == classesBeforeBreak.length + 1) {
                if (!isBefore(endTime, "12:50") && isEqual(endTime, "12:50")) {
                  return null;
                }
                // Render break item
                return TimeLineItem(
                  isFirst: false,
                  isLast: false,
                  isBreak: true,
                  startTime: startTime,
                  endTime: endTime, // Assuming break starts at 12:50
                );
              } else if (index <
                  classesBeforeBreak.length + classesAfterBreak.length + 2) {
                // Render classes after break
                int afterBreakIndex = index -
                    classesBeforeBreak.length -
                    2; // Subtract 2 to account for the first widget and the break item
                return TimeLineItem(
                  isFirst: false,
                  isLast: false,
                  isBreak: false,
                  kClass: classesAfterBreak[afterBreakIndex],
                  startTime: startTime,
                  endTime: endTime, // Assuming first time after break is 13:30
                );
              } else {
                // Render finish widget
                return TimeLineItem(
                  isFirst: false,
                  isBreak: false,
                  isLast: true,
                  endTime: endTime,
                  startTime: startTime,
                );
              }
            },
          );
  }
}

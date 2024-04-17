import 'dart:math';

import 'package:attendease/core/app_colors.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/screens/bottom_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convert24HourTo12Hour(String time24Hour) {
  DateFormat dateFormat = DateFormat('HH:mm');
  DateTime dateTime = dateFormat.parse(time24Hour);
  String time12Hour = DateFormat('h:mm a').format(dateTime);
  return time12Hour;
}

DateTime parseTime(String timeString) {
  List<String> timeParts = timeString.split(':');
  int hours = int.parse(timeParts[0]);
  int minutes = int.parse(timeParts[1]);
  return DateTime(2000, 1, 1, hours,
      minutes); // Date doesn't matter, only time matters for comparison
}

DateTime currentParseTime(String timeString) {
  List<String> timeParts = timeString.split(':');
  int hours = int.parse(timeParts[0]);
  int minutes = int.parse(timeParts[1]);
  DateTime currentTime = DateTime.now();

  return DateTime(
    currentTime.year,
    currentTime.month,
    currentTime.day,
    hours,
    minutes,
  ); // Date doesn't matter, only time matters for comparison
}

bool isAfter(String time1, String time2) {
  // Parse time strings into DateTime objects
  DateTime dateTime1 = DateTime.parse('2000-01-01 $time1');
  DateTime dateTime2 = DateTime.parse('2000-01-01 $time2');

  // Compare hours
  if (dateTime1.hour > dateTime2.hour) {
    return true;
  } else if (dateTime1.hour < dateTime2.hour) {
    return false;
  }

  // If hours are equal, compare minutes
  return dateTime1.minute > dateTime2.minute;
}

bool isBefore(String time1, String time2) {
  // Parse time strings into DateTime objects
  DateTime dateTime1 = DateTime.parse('2000-01-01 $time1');
  DateTime dateTime2 = DateTime.parse('2000-01-01 $time2');

  // Compare hours
  if (dateTime1.hour < dateTime2.hour) {
    return true;
  } else if (dateTime1.hour > dateTime2.hour) {
    return false;
  }

  // If hours are equal, compare minutes
  return dateTime1.minute < dateTime2.minute;
}

bool isEqual(String time1, String time2) {
  // Parse time strings into DateTime objects
  DateTime dateTime1 = DateTime.parse('2000-01-01 $time1');
  DateTime dateTime2 = DateTime.parse('2000-01-01 $time2');

  // Compare hours and minutes
  return dateTime1.hour == dateTime2.hour &&
      dateTime1.minute == dateTime2.minute;
}

String getCurrentDay() {
  int currentDayIndex = DateTime.now().weekday;
  switch (currentDayIndex) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return 'Monday';
  }
}

List<Class> filterClasses(List<Class> allClasses) {
  // Get the current time
  DateTime currentTime = DateTime.now();

  // Filter the list of classes
  List<Class> filteredClasses = allClasses.where((classData) {
    // Parse the endTime string to a DateTime object
    DateTime endTime = DateFormat('HH:mm').parse(classData.endTime);

    // Check if the endTime is before the current time
    return endTime.isBefore(currentTime);
  }).toList();

  return filteredClasses;
}

List<String> getClassIds(List<Class> classes) {
  // Map each class to its id and convert to a list
  List<String> classIds = classes.map((classData) => classData.sId).toList();
  return classIds;
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  String year = now.year.toString();
  String month = now.month.toString().padLeft(2, '0');
  String day = now.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}

String getNextDay(String currentDate) {
  DateTime nextDay = DateTime.parse(currentDate).add(const Duration(days: 1));
  return '${nextDay.year}-${nextDay.month.toString().padLeft(2, '0')}-${nextDay.day.toString().padLeft(2, '0')}';
}

int mapSemesterToYear(int input) {
  // Divide the input by 2 and round up to get the desired value
  return ((input + 1) / 2).ceil();
}

String mapInputToValue(int input) {
  switch (input) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    case 4:
      return 'th';
    default:
      return 'Invalid input';
  }
}

String generateRandomNumber() {
  Random random = Random();
  String number = '';
  for (int i = 0; i < 10; i++) {
    number += random.nextInt(10).toString();
  }
  return number;
}

void bottomSheet(BuildContext context, bool isRecordScreen1) {
  showModalBottomSheet<dynamic>(
      context: context,
      backgroundColor: AppColors.bg100,
      builder: (BuildContext context) {
        return BottomSheetScreen(
          isRecordScreen1: isRecordScreen1,
        );
      });
}

List<String> generateRandomNumbers(int count) {
  Random random = Random();
  List<String> numbers = [];

  for (int i = 0; i < count; i++) {
    // Generate a random 10-digit number
    String number = '';
    for (int j = 0; j < 10; j++) {
      number += random.nextInt(10).toString();
    }
    numbers.add(number);
  }

  return numbers;
}

int getMonthNumber(String monthName) {
  // Convert the month name to lowercase for case-insensitive comparison
  String lowercaseMonthName = monthName.toLowerCase();

  switch (lowercaseMonthName) {
    case 'january':
      return 1;
    case 'february':
      return 2;
    case 'march':
      return 3;
    case 'april':
      return 4;
    case 'may':
      return 5;
    case 'june':
      return 6;
    case 'july':
      return 7;
    case 'august':
      return 8;
    case 'september':
      return 9;
    case 'october':
      return 10;
    case 'november':
      return 11;
    case 'december':
      return 12;
    default:
      // If the provided month name doesn't match any known month, return -1
      return -1;
  }
}

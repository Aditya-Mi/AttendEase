import 'package:attendease/models/class.dart';
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

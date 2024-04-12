import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/widgets/title_item.dart';
import 'package:attendease/screens/list_of_students_screen.dart';
import 'package:attendease/widgets/attendance_item.dart';
import 'package:attendease/widgets/custom_drop_down.dart';
import 'package:attendease/widgets/search_widget.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordsScreen2 extends StatefulWidget {
  const RecordsScreen2({super.key});

  @override
  State<RecordsScreen2> createState() => _RecordsScreen2State();
}

class _RecordsScreen2State extends State<RecordsScreen2> {
  bool _isSearching = false;
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<String> years = [];
  int currentYear = 0;
  int currentMonth = 0;
  int currentDay = 0;
  int noOfDays = 0;
  late String _selectedMonth;
  late String _selectedYear;

  void onMonthChange(String? value) {
    setState(() {
      _selectedMonth = value!;
    });
  }

  void onYearChange(String? value) {
    setState(() {
      _selectedYear = value!;
    });
  }

  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now();
    _selectedMonth = DateFormat.MMMM().format(currentDate);
    currentDay = currentDate.day;
    currentMonth = currentDate.month;
    _selectedYear = DateFormat.y().format(currentDate);
    currentYear = currentDate.year;
    noOfDays = DateUtils.getDaysInMonth(currentYear, currentMonth);
    for (int i = currentYear - 10; i <= currentYear; i++) {
      years.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (_isSearching) {
              setState(() {
                _isSearching = !_isSearching;
              });
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: _isSearching
            ? SearchWidget(
                onChanged: (String? value) {}, onEditingComplete: () {})
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDropDown(
                    selectedMonth: _selectedMonth,
                    items: months,
                    onChanged: onMonthChange,
                    width: 120,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  CustomDropDown(
                    selectedMonth: _selectedYear,
                    items: years,
                    width: 96,
                    onChanged: onYearChange,
                  ),
                ],
              ),
        actions: _isSearching
            ? null
            : [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
      ),
      body: Column(
        children: [
          EasyInfiniteDateTimeLine(
            showTimelineHeader: false,
            dayProps: EasyDayProps(
              width: 82,
              height: 90,
              dayStructure: DayStructure.dayStrDayNumMonth,
              activeDayStyle: DayStyle(
                monthStrStyle:
                    AppText.textStyle(color: AppColors.bg200, size: 16.18),
                dayStrStyle:
                    AppText.textStyle(color: AppColors.bg200, size: 16.18),
                dayNumStyle:
                    AppText.textStyle(color: AppColors.bg100, size: 20),
                decoration: const BoxDecoration(
                  color: AppColors.primary100,
                  border: Border(
                    right: BorderSide(color: AppColors.dateBorderColor),
                  ),
                ),
              ),
              inactiveDayStyle: DayStyle(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(color: AppColors.dateBorderColor),
                  ),
                ),
                monthStrStyle:
                    AppText.textStyle(color: AppColors.text200, size: 16.18),
                dayStrStyle:
                    AppText.textStyle(color: AppColors.text200, size: 16.18),
                dayNumStyle:
                    AppText.textStyle(color: AppColors.text100, size: 20),
              ),
            ),
            timeLineProps: EasyTimeLineProps(
              separatorPadding: 0,
              hPadding: 0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4, color: Colors.black.withOpacity(0.12)),
                ],
              ),
            ),
            firstDate: DateTime(currentYear, currentMonth, 1),
            focusDate: DateTime(currentYear, currentMonth, currentDay),
            lastDate: DateTime(currentYear, currentMonth, noOfDays),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 21),
            decoration: BoxDecoration(
              color: AppColors.bg200,
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Theory.ECE.1E7',
                  style: AppText.textStyle(
                    color: AppColors.text200,
                    size: 16.18,
                  ),
                ),
                const Spacer(),
                Text(
                  'Change',
                  style:
                      AppText.textStyle(color: AppColors.primary100, size: 12),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.primary100,
                  size: 16,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 17,
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 21),
            decoration: BoxDecoration(
              color: AppColors.bg100,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(0.10),
                ),
              ],
            ),
            child: const TitleItem(title: 'Select Subject'),
          ),
          Expanded(
            child: Container(
              color: AppColors.bg200,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ListOfStudentsScreen(),
                      ),
                    ),
                    child: const AttendanceItem(
                      subjectName: 'Microwave Engineering',
                      classType: 'Theory',
                      timings: '1:00 pm- 2:25 pm',
                      roomNumber: '405',
                      section: '8E7',
                      attendance: '58',
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 19,
                  );
                },
                itemCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

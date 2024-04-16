import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_string.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/core/widgets/title_item.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/providers/class_provider.dart';
import 'package:attendease/providers/filter_provider.dart';
import 'package:attendease/screens/list_of_students_screen.dart';
import 'package:attendease/screens/loading_screen.dart';
import 'package:attendease/widgets/attendance_item.dart';
import 'package:attendease/widgets/custom_drop_down.dart';
import 'package:attendease/widgets/search_widget.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RecordsScreen2 extends ConsumerStatefulWidget {
  const RecordsScreen2({super.key});

  @override
  ConsumerState<RecordsScreen2> createState() => _RecordsScreen2State();
}

class _RecordsScreen2State extends ConsumerState<RecordsScreen2> {
  bool _isSearching = false;

  final List<String> years = [];
  int currentYear = 0;
  int currentMonth = 0;
  int currentDay = 0;
  int noOfDays = 0;
  late DateTime _focusDate;
  late String _selectedMonth;
  late String _selectedYear;
  late int _selectedDate;
  final EasyInfiniteDateTimelineController _easyInfiniteDateTimelineController =
      EasyInfiniteDateTimelineController();

  void onMonthChange(String? value) {
    setState(() {
      _selectedMonth = value!;
      _focusDate = DateTime(
        int.parse(_selectedYear),
        getMonthNumber(_selectedMonth),
        _selectedDate,
      );
      _easyInfiniteDateTimelineController.jumpToFocusDate();
    });
  }

  void onYearChange(String? value) {
    setState(() {
      _selectedYear = value!;
      _focusDate = DateTime(
        int.parse(_selectedYear),
        getMonthNumber(_selectedMonth),
        _selectedDate,
      );
      _easyInfiniteDateTimelineController.jumpToFocusDate();
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
    _selectedDate = currentDay;
    noOfDays = DateUtils.getDaysInMonth(currentYear, currentMonth);
    for (int i = currentYear - 10; i <= currentYear; i++) {
      years.add(i.toString());
    }
    _focusDate = DateTime(currentYear, currentMonth, currentDay);
  }

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filterProvider);
    final records =
        ref.watch(recordScreen2Provider(DateFormat('EEEE').format(_focusDate)));
    final classes = ref.read(classProvider).value;
    return SafeArea(
      child: Scaffold(
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
              controller: _easyInfiniteDateTimelineController,
              selectionMode: const SelectionMode.autoCenter(),
              onDateChange: (selectedDate) {
                setState(() {
                  _focusDate = selectedDate;
                  _selectedDate = selectedDate.day;
                });
              },
              showTimelineHeader: false,
              dayProps: EasyDayProps(
                width: 82,
                height: 90,
                dayStructure: DayStructure.dayStrDayNumMonth,
                activeDayStyle: DayStyle(
                  monthStrStyle:
                      MyAppTypography.body2.copyWith(color: AppColors.bg200),
                  dayStrStyle:
                      MyAppTypography.body2.copyWith(color: AppColors.bg200),
                  dayNumStyle: MyAppTypography.textStyle(
                      color: AppColors.bg100, size: 20),
                  decoration: const BoxDecoration(
                    color: AppColors.primary100,
                    border: Border(
                      right: BorderSide(color: AppColors.dateBorderColor),
                    ),
                  ),
                ),
                inactiveDayStyle: todayDayStyle(),
                todayStyle: todayDayStyle(),
              ),
              timeLineProps: EasyTimeLineProps(
                separatorPadding: 0,
                hPadding: 0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.12),
                    ),
                  ],
                ),
              ),
              firstDate: DateTime(
                int.parse(_selectedYear),
                getMonthNumber(_selectedMonth),
                1,
              ),
              focusDate: _focusDate,
              lastDate: DateTime(
                int.parse(_selectedYear),
                getMonthNumber(_selectedMonth),
                DateUtils.getDaysInMonth(
                  int.parse(_selectedYear),
                  getMonthNumber(_selectedMonth),
                ),
              ),
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
                    '${filters.type} . ${reverseBranchMap[filters.branch]} . ${filters.section}',
                    style: MyAppTypography.body4,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      bottomSheet(context, false);
                    },
                    child: Text(
                      'Change',
                      style: MyAppTypography.textStyle(
                          color: AppColors.primary100, size: 12),
                    ),
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
                child: records.when(
                  data: (data) {
                    List<Class> filteredClasses = [];
                    for (var classRecord in data) {
                      var correspondingClass = classes?.firstWhere(
                        (classItem) => classItem.sId == classRecord.id,
                      );
                      if (correspondingClass != null) {
                        filteredClasses.add(correspondingClass);
                      }
                    }
                    return data.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/no_current_class.png'),
                              Text(
                                'No Class was held on this date',
                                style: MyAppTypography.body2.copyWith(
                                  color: const Color(0xffCCCCCC),
                                ),
                              )
                            ],
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              final attendance =
                                  data[index].calculateAttendancePercentage();
                              DateTime tomorrow =
                                  _focusDate.add(const Duration(days: 1));
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ListOfStudentsScreen(
                                      id: filteredClasses[index].sId,
                                      startDate: DateFormat('yyyy-MM-dd')
                                          .format(_focusDate),
                                      endDate: DateFormat('yyyy-MM-dd')
                                          .format(tomorrow),
                                      attendance: attendance,
                                    ),
                                  ),
                                ),
                                child: AttendanceItem(
                                  attendance: attendance,
                                  kClass: filteredClasses[index],
                                  classRecord: data[index],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 19,
                              );
                            },
                            itemCount: data.length,
                          );
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text('An unexpected error occurred'),
                    );
                  },
                  loading: () => const LoadingScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DayStyle todayDayStyle() {
    return DayStyle(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: AppColors.dateBorderColor),
        ),
      ),
      monthStrStyle: MyAppTypography.body4,
      dayStrStyle: MyAppTypography.body4,
      dayNumStyle: MyAppTypography.body2.copyWith(fontSize: 20),
    );
  }
}

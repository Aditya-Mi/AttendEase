import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_shadow.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/core/widgets/custom_circular_indicator.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/models/student_attendance.dart';
import 'package:attendease/providers/class_provider.dart';
import 'package:attendease/screens/loading_screen.dart';
import 'package:attendease/screens/success_screen.dart';
import 'package:attendease/widgets/search_widget.dart';
import 'package:attendease/widgets/take_attendance_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TakeAttendanceScreen extends ConsumerStatefulWidget {
  final Class kClass;
  const TakeAttendanceScreen({super.key, required this.kClass});

  @override
  ConsumerState<TakeAttendanceScreen> createState() =>
      _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends ConsumerState<TakeAttendanceScreen> {
  bool _isSearching = false;
  bool _isLoading = false;
  late List<StudentAttendance> _listOfStudentAttendance = [];
  late List<String> enrollment;

  List<SubmitStudent> convertToSubmitStudents(
      List<StudentAttendance> studentAttendanceList) {
    List<SubmitStudent> submitStudents = [];

    for (var studentAttendance in studentAttendanceList) {
      String status;
      if (studentAttendance.attendanceStatus == AttendanceStatus.None ||
          studentAttendance.attendanceStatus == AttendanceStatus.Absent) {
        status = 'Absent';
      } else {
        status = 'Present';
      }

      submitStudents.add(
        SubmitStudent(
          student: studentAttendance.studentId,
          kClass: studentAttendance.classId,
          date: studentAttendance.date,
          status: status,
        ),
      );
    }

    return submitStudents;
  }

  @override
  void initState() {
    enrollment = generateRandomNumbers(50);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final records = ref.watch(singleClassAttendanceRecords(widget.kClass.sId));
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
              : const Text('Take Attendance'),
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
        body: records.when(
          data: (data) {
            if (_listOfStudentAttendance.isEmpty) {
              _listOfStudentAttendance = data.students
                  .map(
                    (student) => StudentAttendance(
                      studentId: student.id,
                      attendanceStatus: AttendanceStatus.None,
                      date: DateTime.now().toString(),
                      classId: widget.kClass.sId,
                    ),
                  )
                  .toList();
            }
            bool showButton = _listOfStudentAttendance.any(
              (attendance) =>
                  attendance.attendanceStatus != AttendanceStatus.None,
            );

            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 21),
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: AppColors.bg100,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(0.05),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.kClass.topic} | ${widget.kClass.type} | ${widget.kClass.section}',
                        style: MyAppTypography.body2,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Total Students : ${data.students.length}',
                        style: MyAppTypography.body2,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    itemCount: data.students.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 21,
                      );
                    },
                    itemBuilder: (context, index) {
                      return TakeAttendanceItem(
                        student: data.students[index],
                        studentAttendance: _listOfStudentAttendance[index],
                        noOfClasses: data.noOfClasses,
                        enrollment: enrollment[index],
                        onAttendanceChanged: (status) {
                          setState(() {
                            _listOfStudentAttendance[index].attendanceStatus =
                                status;
                          });
                        },
                      );
                    },
                  ),
                ),
                showButton
                    ? Container(
                        height: 64,
                        width: double.infinity,
                        color: AppColors.bg100,
                        alignment: Alignment.center,
                        child: _isLoading
                            ? const CustomCircularIndicator()
                            : GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  bool result = await ref
                                      .read(classRepositoryProvider)
                                      .submitAttendance(
                                        convertToSubmitStudents(
                                            _listOfStudentAttendance),
                                      );
                                  if (result && context.mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SuccessScreen(),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'An error occurred. Please try again.'),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 50,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.primary100,
                                    boxShadow: [
                                      MyAppBoxShadow.myCustomBoxShadow(
                                        Colors.black.withOpacity(
                                          0.10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'Done',
                                    style: MyAppTypography.body4
                                        .copyWith(color: AppColors.bg100),
                                  ),
                                ),
                              ),
                      )
                    : const SizedBox()
              ],
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child:
                  Text('An unexpected error occurred. Please try again later'),
            );
          },
          loading: () => const LoadingScreen(),
        ),
      ),
    );
  }
}

import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/core/widgets/title_item.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/models/filters.dart';
import 'package:attendease/providers/class_provider.dart';
import 'package:attendease/providers/filter_provider.dart';
import 'package:attendease/screens/loading_screen.dart';
import 'package:attendease/widgets/today_attendance_widget.dart.dart';
import 'package:attendease/widgets/semester_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecordsScreen extends ConsumerWidget {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classRecords = ref.watch(currentClassRecordProvider);
    final classes = ref.read(classProvider).value;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Records'),
        ),
        body: classRecords.when(
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const TitleItem(title: 'Todays Attendance'),
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28),
                          child: TodayAttendanceItem(
                            kClass: filteredClasses[index],
                            classRecord: data[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 9,
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                  const TitleItem(title: 'Teaching Semesters'),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 41),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 27,
                        crossAxisCount: 2,
                        mainAxisExtent: 100,
                        crossAxisSpacing: 27,
                        childAspectRatio: 1.1844,
                      ),
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            ref.read(filterProvider.notifier).update(
                                  (state) => Filters(
                                    semester: index,
                                    branch: state.branch,
                                    section: state.section,
                                    type: state.type,
                                  ),
                                );
                            bottomSheet(context, true);
                          },
                          child: SemesterItem(semNo: index + 1),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          },
          loading: () {
            return const LoadingScreen();
          },
        ),
      ),
    );
  }
}

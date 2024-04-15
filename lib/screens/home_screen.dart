import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/functions.dart';
import 'package:attendease/core/widgets/title_item.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/providers/class_provider.dart';
import 'package:attendease/screens/loading_screen.dart';
import 'package:attendease/widgets/current_class_item.dart';
import 'package:attendease/widgets/upcoming_class_item.dart';
import 'package:attendease/core/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final classes = ref.watch(classProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AttendEase'),
        ),
        body: classes.when(
          data: (data) {
            final currentDayName = getCurrentDay();
            List<Class> classesOnCurrentDay = data.where((classData) {
              return classData.dayOfWeek.contains(currentDayName);
            }).toList();
            classesOnCurrentDay.sort((a, b) {
              DateTime startTimeA = parseTime(a.startTime);
              DateTime startTimeB = parseTime(b.startTime);
              return startTimeA.compareTo(startTimeB);
            });
            DateTime currentTime = DateTime.now();
            Class? ongoingClass;
            for (var classData in classesOnCurrentDay) {
              DateTime startTime = parseTime(classData.startTime);
              DateTime endTime = parseTime(classData.endTime);
              if (startTime.isBefore(currentTime) &&
                  endTime.isAfter(currentTime)) {
                ongoingClass = classData;
                break;
              }
            }

            // Remove the ongoing class from the list
            if (ongoingClass != null) {
              classesOnCurrentDay.remove(ongoingClass);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 15),
              child: Column(
                children: [
                  const TitleItem(title: 'Current Class'),
                  const SizedBox(
                    height: 32,
                  ),
                  ongoingClass != null
                      ? CurrentClassItem(
                          kClass: ongoingClass,
                        )
                      : Column(
                          children: [
                            Image.asset('assets/images/no_current_class.png'),
                            Text(
                              'No Class is live at the moment',
                              style: MyAppTypography.body2.copyWith(
                                color: const Color(0xffCCCCCC),
                              ),
                            )
                          ],
                        ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18, bottom: 14),
                    child: CustomDivider(color: Color(0xffF1ECEC)),
                  ),
                  const TitleItem(title: 'Upcoming Classes'),
                  const SizedBox(
                    height: 32,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 20, top: 26),
                      decoration: BoxDecoration(
                        color: AppColors.bg200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return UpcomingClassItem(
                            kClass: classesOnCurrentDay[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 60),
                            child: CustomDivider(
                              color: AppColors.primary200.withOpacity(0.25),
                            ),
                          );
                        },
                        itemCount: classesOnCurrentDay.length,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text("An unexpected error occurred"),
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

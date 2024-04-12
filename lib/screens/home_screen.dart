import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/widgets/title_item.dart';
import 'package:attendease/widgets/current_class_item.dart';
import 'package:attendease/widgets/upcoming_class_item.dart';
import 'package:attendease/core/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AttendEase'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 15),
        child: Column(
          children: [
            const TitleItem(title: 'Current Class'),
            const SizedBox(
              height: 32,
            ),
            const CurrentClassItem(
              subjectName: 'VLSI Design',
              classType: 'Theory',
              timings: '1:00 pm- 2:25 pm',
              roomNumber: '405',
              section: '8E7',
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
                    return const UpcomingClassItem(
                      subjectName: 'VLSI Design',
                      classType: 'Theory',
                      timings: '1:00 pm- 2:25 pm',
                      roomNumber: '405',
                      section: '8E7',
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
                  itemCount: 6,
                ),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
          ],
        ),
      ),
    );
  }
}

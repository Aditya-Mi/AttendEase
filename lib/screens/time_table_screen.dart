import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/providers/class_provider.dart';
import 'package:attendease/screens/loading_screen.dart';
import 'package:attendease/widgets/time_table_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeTableScreen extends ConsumerStatefulWidget {
  const TimeTableScreen({super.key});

  @override
  ConsumerState<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends ConsumerState<TimeTableScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 6, vsync: this, initialIndex: DateTime.now().weekday);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final classes = ref.watch(classProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Time Table'),
        ),
        body: classes.when(data: (data) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.bg200,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.10),
                    ),
                  ],
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primary100,
                  ),
                  labelStyle: MyAppTypography.textStyle(
                    color: AppColors.bg100,
                    size: 15,
                  ),
                  unselectedLabelStyle:
                      MyAppTypography.body3.copyWith(fontSize: 15),
                  tabs: const [
                    Tab(text: 'Mon'),
                    Tab(text: 'Tue'),
                    Tab(text: 'Wed'),
                    Tab(text: 'Thu'),
                    Tab(text: 'Fri'),
                    Tab(text: 'Sat'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TimeTableItem(classes: data, day: 'Monday'),
                    TimeTableItem(classes: data, day: 'Tuesday'),
                    TimeTableItem(classes: data, day: 'Wednesday'),
                    TimeTableItem(classes: data, day: 'Thursday'),
                    TimeTableItem(classes: data, day: 'Friday'),
                    TimeTableItem(classes: data, day: 'Saturday'),
                  ],
                ),
              ),
            ],
          );
        }, error: (error, stackTrace) {
          return const Center(child: Text("An unexpected error occurred"));
        }, loading: () {
          return const LoadingScreen();
        }),
      ),
    );
  }
}

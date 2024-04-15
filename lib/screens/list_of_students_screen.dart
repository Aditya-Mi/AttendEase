import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/models/class_record.dart';
import 'package:attendease/providers/class_provider.dart';
import 'package:attendease/providers/filter_provider.dart';
import 'package:attendease/screens/login_screen.dart';
import 'package:attendease/widgets/search_widget.dart';
import 'package:attendease/widgets/student_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListOfStudentsScreen extends ConsumerStatefulWidget {
  final String id;
  final String startDate;
  final String endDate;
  const ListOfStudentsScreen(
      {super.key,
      required this.id,
      required this.startDate,
      required this.endDate});

  @override
  ConsumerState<ListOfStudentsScreen> createState() =>
      _ListOfStudentsScreenState();
}

class _ListOfStudentsScreenState extends ConsumerState<ListOfStudentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final records = ref.watch(
      singleClassRecordProvider(
        [widget.id, widget.startDate, widget.endDate],
      ),
    );
    return SafeArea(
      child: Scaffold(
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
              : const Text('List of Students'),
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
            return Column(
              children: [
                Container(
                  height: 53,
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
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    indicator: const BoxDecoration(
                      color: AppColors.primary100,
                    ),
                    labelStyle: MyAppTypography.textStyle(
                        color: AppColors.bg100, size: 18),
                    unselectedLabelStyle:
                        MyAppTypography.body2.copyWith(fontSize: 18),
                    tabs: const [
                      Tab(
                        text: 'Present',
                      ),
                      Tab(
                        text: 'Absent',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      StudentsList(
                        title: 'Present',
                        students: data.students,
                      ),
                      StudentsList(
                        title: 'Absent',
                        students: data.students,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text('An unexpected error occurred'),
            );
          },
          loading: () => const LoginScreen(),
        ),
      ),
    );
  }
}

class StudentsList extends ConsumerWidget {
  final String title;
  final List<Student> students;
  const StudentsList({super.key, required this.title, required this.students});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filterProvider);
    List<Student> filterList = students.where((element) {
      return element.status == title;
    }).toList();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 21),
          margin: const EdgeInsets.only(bottom: 24),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: AppColors.bg200,
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(0.10),
              ),
            ],
          ),
          child: Text(
            'Number of Students $title : ${filterList.length}',
            style: MyAppTypography.body4,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: filterList.isEmpty
                ? Column(
                    children: [
                      title == 'Present'
                          ? Image.asset('assets/images/sad.png')
                          : Image.asset('assets/images/smile.png'),
                      title == 'Present'
                          ? Text(
                              'No one was Present',
                              style: MyAppTypography.body4,
                            )
                          : Text(
                              'No one was Absent',
                              style: MyAppTypography.body4,
                            )
                    ],
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return StudentItem(
                        filters: filters,
                        student: filterList[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 24,
                      );
                    },
                    itemCount: filterList.length,
                  ),
          ),
        ),
      ],
    );
  }
}

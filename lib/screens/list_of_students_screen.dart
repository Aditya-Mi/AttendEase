import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/widgets/search_widget.dart';
import 'package:attendease/widgets/student_item.dart';
import 'package:flutter/material.dart';

class ListOfStudentsScreen extends StatefulWidget {
  const ListOfStudentsScreen({super.key});

  @override
  State<ListOfStudentsScreen> createState() => _ListOfStudentsScreenState();
}

class _ListOfStudentsScreenState extends State<ListOfStudentsScreen>
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
    return Scaffold(
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
      body: Column(
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
              labelStyle: AppText.textStyle(color: AppColors.bg100, size: 18),
              unselectedLabelStyle:
                  AppText.textStyle(color: AppColors.text100, size: 18),
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
              children: const [
                StudentsList(title: 'Present', noOfStudents: 20),
                StudentsList(title: 'Absent', noOfStudents: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StudentsList extends StatelessWidget {
  final String title;
  final int noOfStudents;
  const StudentsList(
      {super.key, required this.title, required this.noOfStudents});

  @override
  Widget build(BuildContext context) {
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
            'Number of Students $title : $noOfStudents',
            style: AppText.textStyle(
              color: AppColors.text200,
              size: 16.18,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return const StudentItem();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 24,
                );
              },
              itemCount: noOfStudents,
            ),
          ),
        ),
      ],
    );
  }
}

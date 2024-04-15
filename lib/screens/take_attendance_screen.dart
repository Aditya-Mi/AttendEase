import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/widgets/search_widget.dart';
import 'package:attendease/widgets/take_attendance_item.dart';
import 'package:flutter/material.dart';

class TakeAttendanceScreen extends StatefulWidget {
  const TakeAttendanceScreen({super.key});

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 21),
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
                    'Microwave Engineering | Theory | 8E7',
                    style: MyAppTypography.body2,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Total Students : 40',
                    style: MyAppTypography.body2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                itemCount: 10,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 21,
                  );
                },
                itemBuilder: (context, index) {
                  return const TakeAttendanceItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

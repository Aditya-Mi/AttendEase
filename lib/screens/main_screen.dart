import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/screens/home_screen.dart';
import 'package:attendease/screens/records_screen.dart';
import 'package:attendease/screens/settings_screen.dart';
import 'package:attendease/screens/time_table_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final screens = [
    const HomeScreen(),
    const TimeTableScreen(),
    const RecordsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.bg200,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: const IconThemeData(color: AppColors.primary100),
          unselectedIconTheme: const IconThemeData(color: AppColors.text200),
          selectedLabelStyle:
              AppText.textStyle(color: AppColors.primary100, size: 12.94),
          unselectedLabelStyle:
              AppText.textStyle(color: AppColors.text200, size: 12.94),
          elevation: 0.0,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home_outlined,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Time Table',
              icon: Icon(
                Icons.pending_actions,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Records',
              icon: Icon(
                Icons.person,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(
                Icons.settings_outlined,
              ),
            ),
          ],
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
        ),
      ),
    );
  }
}

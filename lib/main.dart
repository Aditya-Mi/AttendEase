import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'DMSans',
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.accent200,
          titleTextStyle: AppText.textStyle(
            color: Colors.white,
            size: 22.65,
          ),
          centerTitle: true,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

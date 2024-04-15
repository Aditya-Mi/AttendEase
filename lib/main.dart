import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/repositories/shared_preferences_repository.dart';
import 'package:attendease/screens/login_screen.dart';
import 'package:attendease/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String? token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  token = await SharedPreferencesRepository().getToken();
  token ??= '';
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AttendEase',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'DMSans',
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.accent200,
          titleTextStyle: MyAppTypography.textStyle(
            color: Colors.white,
            size: 22.65,
          ),
          centerTitle: true,
        ),
      ),
      home: token == '' ? const LoginScreen() : const MainScreen(),
    );
  }
}

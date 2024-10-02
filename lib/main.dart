import 'package:flutter/material.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/splashscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Community',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColor),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        primaryColor: AppColors.backgroundColor,
        primaryTextTheme:
            TextTheme(headlineMedium: TextStyle(color: AppColors.primaryColor)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    WidgetStatePropertyAll(AppColors.primaryColor))),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.backgroundColor),
      ),
      home: const Scaffold(
        body: Center(child: SplashScreen()),
      ),
    );
  }
}

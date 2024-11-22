import 'package:flutter/material.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/homescreen.dart';
import 'package:local_community/Screens/loginscreen.dart';
import 'package:local_community/Screens/registerscreen.dart';
import 'package:local_community/Screens/splashscreen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/login',
      // routes: {
      //   'login':(context)=>LoginScreen(),
      //   "register":(context)=>RegisterScreen(),
      //   "home":(context)=>HomeScreen(),
      // },
      debugShowCheckedModeBanner: false,
      title: 'Local Community',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: AppColors.txtColor,
            ),
            backgroundColor: AppColors.backgroundColor,
            titleTextStyle: TextStyle(
                color: AppColors.txtColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
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
      home: Scaffold(
        body: Center(child: SplashScreen()),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/splash_screen.dart';
import 'package:task_manager/ui/utilitys/app_colors.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: lightThemeData(),
    );
  }

  ThemeData lightThemeData() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.grey.shade400
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          padding: EdgeInsets.symmetric(vertical: 12),
          foregroundColor: AppColors.white,
          fixedSize: Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )

        )
      )
    );
  }
}
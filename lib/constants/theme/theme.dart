import 'package:flutter/material.dart';

class MyThemeData {
  static Color primaryColor = Color(0xFF24293d);
  static Color second = Color(0xFFff6a6c);
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xFFf5f6fa),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: primaryColor)),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 28, color: primaryColor, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
          color: primaryColor,
          fontSize: 17,
        ),
      ));
}

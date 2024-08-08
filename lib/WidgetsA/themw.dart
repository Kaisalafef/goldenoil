import 'package:flutter/material.dart';

class Thems {
  static ThemeData customDarkThem = ThemeData.dark().copyWith(
      // TextTheme(titleMedium: TextStyle(color: Colors.white)),
      appBarTheme: AppBarTheme(
        
          color: Colors.teal,
          titleTextStyle: TextStyle(color: Colors.blueGrey)),
      bottomNavigationBarTheme:  BottomNavigationBarThemeData(
          backgroundColor: Colors.blueGrey, unselectedItemColor: Colors.white));
  static ThemeData customlightThem = ThemeData.light().copyWith(
      textTheme: TextTheme(titleMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white, unselectedItemColor: Colors.black));
}

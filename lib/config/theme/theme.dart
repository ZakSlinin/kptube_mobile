import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  scaffoldBackgroundColor: Color.fromARGB(255, 15, 15, 15),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 20, 20, 24),
  ),
);

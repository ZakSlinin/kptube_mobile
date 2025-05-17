import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: Color.fromARGB(255, 15, 15, 15),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 20, 20, 24),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 20),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white, fontSize: 20),
    contentPadding: EdgeInsets.all(4),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 20, 20, 24),
  )
);

import 'package:flutter/material.dart';

ThemeData getTheme() {
  return ThemeData(
    primarySwatch: Colors.purple,
    primaryColor: Colors.green[900],
    appBarTheme: AppBarTheme(
      color: Colors.green[900],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.purple[500],
    ),
  );
}

import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,

  appBarTheme: const AppBarTheme(backgroundColor: Colors.black, elevation: 0),

  iconTheme: const IconThemeData(color: Colors.white),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white70),
  ),
);

import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blue,
  splashColor: Colors.blueAccent,
  highlightColor: Colors.blue,
  fontFamily: 'Muli',
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
).copyWith(
  colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.blueAccent),
);

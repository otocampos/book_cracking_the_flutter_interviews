import 'package:chapter_13_final/core/utils/branding_colors.dart';
import 'package:flutter/material.dart';

final ThemeData mainTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    foregroundColor: Colors.white,
    scrolledUnderElevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 15,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ProjectColors.packtOrange,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),),
  ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ProjectColors.packtOrange,
        foregroundColor: Colors.white
    )

);

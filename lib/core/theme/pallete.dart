// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Palette {
  static const dark_bg = Color(0xFF15181C);
  static const dark_surface = Color(0xFF212529);
  static const dark_primaryColor = Color(0xFF6F7BFF);
  static const error = Colors.red;
  static const onPrimary = Colors.white;
  static const text_grey = Color(0xFF8C8C8C);

  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: dark_bg,
    cardColor: dark_surface,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    primaryColor: dark_primaryColor,
    inputDecorationTheme: _darkinputDecorationTheme,
    elevatedButtonTheme: _elevatedButtonThemeData,
  );

  static final InputDecorationTheme _darkinputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: dark_surface,
    floatingLabelBehavior: FloatingLabelBehavior.always,

    // Border when the input is not focused
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    ),

    // Border when the input is focused
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    ),

    // Error border
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    ),

    // Error text style
    errorStyle: const TextStyle(color: error),

    // Content padding
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  );

  static final ElevatedButtonThemeData _elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: dark_primaryColor,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

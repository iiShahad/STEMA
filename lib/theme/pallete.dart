import 'package:flutter/material.dart';

class Palette {
  static const dark_bg = Color(0xFF15181C);
  static const dark_surface = Color(0xFF212529);
  static const dark_primaryColor = Color(0xFF6F7BFF);

  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: dark_bg,
    cardColor: dark_surface,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    primaryColor: dark_primaryColor,
  );
}

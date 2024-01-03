import 'package:flutter/material.dart';

class ScreenSizeConstants {
  static const double sm = 640;
  static const double md = 768;
  static const double lg = 1024;
  static const double xl = 1280;
  static const double xxl = 1536;

  static double Function(BuildContext context) screenHeight =
      (BuildContext context) {
    return MediaQuery.of(context).size.height;
  };

  static double Function(BuildContext context) screenWidth =
      (BuildContext context) {
    return MediaQuery.of(context).size.width;
  };

  static double Function(BuildContext context) quarterSize =
      (BuildContext context) {
    return MediaQuery.of(context).size.width * (1 / 4);
  };

  static double Function(BuildContext context) thirdSize =
      (BuildContext context) {
    return MediaQuery.of(context).size.width * (1 / 3);
  };

  static double Function(BuildContext context) halfSize =
      (BuildContext context) {
    return MediaQuery.of(context).size.width * (1 / 2);
  };

  static double Function(BuildContext context) twoFifths =
      (BuildContext context) {
    return MediaQuery.of(context).size.width * (2 / 5);
  };
}

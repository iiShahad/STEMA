import 'package:flutter/material.dart';
import 'package:stema/features/auth/view/auth_screen.dart';
import 'core/core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STEMA',
      theme: Palette.darkModeAppTheme,
      home: const AuthScreen(),
    );
  }
}

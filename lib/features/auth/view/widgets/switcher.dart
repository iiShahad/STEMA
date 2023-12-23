import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/core/theme/pallete.dart';

class Switcher extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSignin;
  const Switcher({super.key, required this.onTap, required this.isSignin});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: isSignin
                  ? "Don't have an account?"
                  : "Already have an account?",
              style: const TextStyle(color: Palette.text_grey)),
          TextSpan(
            text: isSignin ? " Sign up" : " Sign in",
            style: const TextStyle(color: Palette.dark_primaryColor),
            recognizer: TapGestureRecognizer()..onTap = () => onTap(),
          ),
        ],
      ),
    );
  }
}

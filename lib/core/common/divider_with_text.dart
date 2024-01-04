import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final Color color;
  const DividerWithText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Divider(
          color: color,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
      ),
      Expanded(
        child: Divider(
          color: color,
        ),
      ),
    ]);
  }
}

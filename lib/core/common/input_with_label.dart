import 'package:flutter/material.dart';

import '../core.dart';

class InputWithLabel extends StatelessWidget {
  final String? Function(String?) validator;
  final void Function(String?) onChanged;
  final bool obsecureText;
  final String label;
  const InputWithLabel({
    super.key,
    required this.label,
    required this.validator,
    required this.onChanged,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Palette.text_grey, fontSize: 18),
        ),
        TextFormField(
          validator: validator,
          onChanged: onChanged,
          obscureText: obsecureText,
          cursorColor: Palette.dark_primaryColor,
        ),
      ],
    );
  }
}

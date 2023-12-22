import 'package:flutter/material.dart';
import '../../../../core/common/input_with_label.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth * 0.5,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const InputWithLabel(label: "Username"),
              const SizedBox(height: 20),
              const InputWithLabel(label: "Email"),
              const SizedBox(height: 20),
              const InputWithLabel(label: "Password"),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(constraints.maxWidth * 0.25, 50),
                ),
                child: const Text("Sign Up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

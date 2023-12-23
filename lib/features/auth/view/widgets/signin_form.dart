import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/features/auth/repository/auth_repository.dart';
import '../../../../core/common/input_with_label.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth * 0.5,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const InputWithLabel(label: "Email"),
              const SizedBox(height: 20),
              const InputWithLabel(label: "Password"),
              const SizedBox(height: 50),
              Consumer(
                builder: (context, ref, child) => ElevatedButton(
                  onPressed: () {
                    ref
                        .read(authRepositoryProvider)
                        .signup("testsss@test.com", "password");
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(constraints.maxWidth * 0.25, 50),
                  ),
                  child: const Text("Sign in"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

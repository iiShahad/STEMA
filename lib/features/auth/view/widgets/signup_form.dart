import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/core/common/input_with_label.dart';
import 'package:stema/core/utils.dart';
import 'package:stema/features/auth/controller/auth_controller.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String email = "";
  String password = "";

  void _submit() {
    if (_formKey.currentState!.validate()) {
      //on success validating
      ref.read(authControllerProvider).signup(username, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth * 0.5,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputWithLabel(
                label: "Username",
                validator: usernameValidator,
                onChanged: (value) => setState(() {
                  username = value!;
                }),
              ),
              const SizedBox(height: 20),
              InputWithLabel(
                  label: "Email",
                  validator: emailValidator,
                  onChanged: (value) => setState(() {
                        email = value!;
                      })),
              const SizedBox(height: 20),
              InputWithLabel(
                label: "Password",
                validator: passwordValidator,
                onChanged: (value) => setState(() {
                  password = value!;
                }),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => _submit(),
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

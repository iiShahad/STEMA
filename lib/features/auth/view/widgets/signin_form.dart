import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/core/common/input_with_label.dart';
import 'package:stema/core/utils.dart';
import 'package:stema/features/auth/controller/auth_controller.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  void _submit() {
    if (_formKey.currentState!.validate()) {
      //on success validating
      ref.read(authControllerProvider).signin(email, password);
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
                label: "Email",
                validator: emailValidator,
                onChanged: (value) => setState(() {
                  email = value!;
                }),
              ),
              const SizedBox(height: 20),
              InputWithLabel(
                label: "Password",
                validator: passwordValidator,
                onChanged: (value) => setState(() {
                  password = value!;
                }),
              ),
              const SizedBox(height: 50),
              Consumer(
                builder: (context, ref, child) => ElevatedButton(
                  onPressed: () => _submit(),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stema/core/core.dart';
import 'package:stema/features/auth/view/widgets/signin_form.dart';
import 'package:stema/features/auth/view/widgets/signup_form.dart';
import 'package:stema/features/auth/view/widgets/switcher.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AssetsConstants.logo),
                  const SizedBox(height: 70),
                  isSignin ? const SignInForm() : const SignUpForm(),
                  const SizedBox(height: 20),
                  Switcher(
                    isSignin: isSignin,
                    onTap: () {
                      setState(() {
                        isSignin = !isSignin;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          SvgPicture.asset(
            AssetsConstants.pattern,
            fit: BoxFit.cover,
            width: ScreenSizeConstants.thirdSize(context),
          ),
        ],
      ),
    );
  }
}

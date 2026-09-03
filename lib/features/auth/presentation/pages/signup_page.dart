import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const SizedBox(height: 120),
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 50, fontWeight: .bold),
                  ),
                  const SizedBox(height: 30),
                  const AuthField(hinttext: "Name"),
                  const SizedBox(height: 16),
                  const AuthField(hinttext: "Email"),
                  const SizedBox(height: 16),
                  const AuthField(hinttext: "Password", isPassword: true),
                  const SizedBox(height: 18),
                  const AuthGradientButton(),
                  const SizedBox(height: 18),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: " Sign in",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppPallete.gradient2,
                                fontWeight: .bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

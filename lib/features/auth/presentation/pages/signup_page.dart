import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/show_snackbar.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static route() => MaterialPageRoute(builder: (contex) => SignupPage());

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              showSnakBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      const SizedBox(height: 120),
                      const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 50, fontWeight: .bold),
                      ),
                      const SizedBox(height: 30),
                      AuthField(hinttext: "Name", controller: _nameController),
                      const SizedBox(height: 16),
                      AuthField(
                        hinttext: "Email",
                        controller: _emailController,
                      ),
                      const SizedBox(height: 16),
                      AuthField(
                        hinttext: "Password",
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 18),
                      AuthGradientButton(
                        label: "Sign Up",
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            print("button is pressed");
                            context.read<AuthBloc>().add(
                              AuthSignUp(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                name: _nameController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, LoginPage.route());
                        },
                        child: RichText(
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

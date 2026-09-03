import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.hinttext,
    this.validator,
    this.isPassword = false,
    this.controller,
  });
  final String hinttext;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextEditingController? controller;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: widget.isPassword ? hidePassword : !hidePassword,
      controller: widget.controller,

      decoration: InputDecoration(
        hintText: widget.hinttext,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  hidePassword = !hidePassword;
                  setState(() {});
                },
                child: Icon(
                  hidePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  BlogEditor({super.key, required this.controller, this.hintText});
  final TextEditingController controller;
  String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      maxLines: null,
    );
  }
}

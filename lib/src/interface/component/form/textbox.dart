import 'package:flutter/material.dart';

class Textbox extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final int numberOfLines;
  const Textbox({super.key, required this.labelText, required this.controller, this.numberOfLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
       maxLines: numberOfLines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}

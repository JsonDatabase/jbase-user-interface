import 'package:flutter/material.dart';

class LabelTextBox extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final int numberOfLines;
  final bool enabled;
  const LabelTextBox(
      {super.key,
      required this.labelText,
      required this.controller,
      this.numberOfLines = 1,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: numberOfLines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
        labelText: labelText,
        enabled: enabled,
      ),
    );
  }
}

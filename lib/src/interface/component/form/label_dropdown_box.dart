import 'package:flutter/material.dart';

class LabelDropdownBox extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final String? selectedItem;
  final Function(String?)? onChanged;

  const LabelDropdownBox(
      {super.key,
      required this.labelText,
      required this.items,
      required this.selectedItem,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LabelCheckBox extends StatefulWidget {
  final String labelText;
  final bool value;
  final void Function(bool?)? onChanged;
  const LabelCheckBox(
      {super.key,
      required this.labelText,
      required this.value,
      required this.onChanged});

  @override
  State<LabelCheckBox> createState() => _LabelCheckBoxState();
}

class _LabelCheckBoxState extends State<LabelCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.value,
          onChanged: widget.onChanged,
        ),
        const SizedBox(width: 5),
        Text(widget.labelText,
            style: Theme.of(context)
                .primaryTextTheme
                .labelLarge!
                .copyWith(color: Colors.black)),
      ],
    );
  }
}

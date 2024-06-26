import 'package:flutter/material.dart';

import 'AutoDirection.dart';

class AutoDirectionTextField extends StatefulWidget {
  final TextEditingController controller;
  final Map<String, String> locale;
  final String? hintText;
  final bool isUnderLinedBorder;
  final int? maxLines;
  final TextStyle? style;

  const AutoDirectionTextField(
      {super.key,
      required this.controller,
      required this.locale,
      this.hintText,
      this.isUnderLinedBorder = true,
      this.maxLines = 1,
      this.style});

  @override
  State<AutoDirectionTextField> createState() =>
      _AutoDirectionTextFormFieldState();
}

class _AutoDirectionTextFormFieldState extends State<AutoDirectionTextField> {
  @override
  Widget build(BuildContext context) {
    return AutoDirection(
      text: widget.controller.text != ''
          ? widget.controller.text[0]
          : widget.controller.text,
      child: TextField(
        maxLines: widget.maxLines,
        controller: widget.controller,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
            hintText:
                widget.hintText == null ? "" : widget.locale[widget.hintText]!,
            border: widget.isUnderLinedBorder ? null : InputBorder.none),
        style: widget.style,
      ),
    );
  }
}

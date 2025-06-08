import 'PrimaryContainer.dart';
import 'package:flutter/material.dart';

import 'AutoDirection.dart';

class AutoDirectionTextFormField extends StatefulWidget {
  final TextEditingController controller;

  final String errMessage;
  final String hintText;

  final int? maxLines;

  const AutoDirectionTextFormField(
      {super.key,
      required this.controller,
      required this.errMessage,
      required this.hintText,
      this.maxLines = 1});

  @override
  State<AutoDirectionTextFormField> createState() =>
      _AutoDirectionTextFormFieldState();
}

class _AutoDirectionTextFormFieldState
    extends State<AutoDirectionTextFormField> {
  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      paddingHorizontal: 20,
      padding: 0,
      child: AutoDirection(
        text: widget.controller.text != ''
            ? widget.controller.text[0]
            : widget.controller.text,
        child: TextFormField(
          maxLines: widget.maxLines,
          controller: widget.controller,
          onChanged: (value) {
            setState(() {});
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.errMessage;
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: widget.hintText, border: InputBorder.none),
        ),
      ),
    );
  }
}

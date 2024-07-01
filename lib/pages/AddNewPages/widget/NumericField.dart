import 'package:achivement_box/models/PrimaryContainer.dart';
import 'package:flutter/material.dart';

class NumericField extends StatelessWidget {
  const NumericField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.maxValue});
  final TextEditingController controller;
  final int maxValue;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      paddingHorizontal: 20,
      padding: 0,
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(),
        validator: (value) {
          int val = int.parse(value ?? "0");
          if (value == null || value.isEmpty) {
            return "please enter a number";
          } else if (val > maxValue) {
            return "value must be less than $maxValue";
          } else if (val < 0) {
            return "value must be greater than 0";
          }
          return null;
        },
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NumericField extends StatelessWidget {
  const NumericField(
      {super.key, required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Theme.of(context).primaryColor.withOpacity(0.2)),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "please enter a number";
          }
          return null;
        },
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class IsBad extends StatefulWidget {
  IsBad({super.key});

  @override
  State<IsBad> createState() => _IsBadState();
  bool value = false;
}

class _IsBadState extends State<IsBad> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: const Text("Is Bad? "),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide.none),
        value: widget.value,
        onChanged: (value) {
          widget.value = value;
          setState(() {});
        });
  }
}

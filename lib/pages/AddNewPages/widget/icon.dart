import 'package:flutter/material.dart';

class SelectIcon extends StatelessWidget {
  const SelectIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Theme.of(context).primaryColor.withOpacity(0.1)),
        child: const Icon(Icons.add));
  }
}

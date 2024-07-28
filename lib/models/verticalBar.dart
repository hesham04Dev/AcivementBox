import 'package:flutter/material.dart';

import 'PrimaryContainer.dart';

class VerticalBar extends StatelessWidget {
  final String text;
  final double filledHeight;
  final double filledWidth;
  const VerticalBar(
      {super.key,
      required this.text,
      required this.filledHeight,
      required this.filledWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        PrimaryContainer(
          opacity: 0.5,
          margin: 0,
          height: filledHeight,
          width: filledWidth,
          child: const SizedBox(),
        ),
        // const Text("d")
      ],
    );
  }
}

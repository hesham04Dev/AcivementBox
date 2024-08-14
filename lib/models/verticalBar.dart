import 'package:auto_size_text/auto_size_text.dart';
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
        AutoSizeText(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          maxFontSize: 12,
          minFontSize: 9,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        PrimaryContainer(
          opacity: 1,
          margin: 0,
          height: filledHeight,
          width: filledWidth,
          child: const SizedBox(),
        ),
      ],
    );
  }
}

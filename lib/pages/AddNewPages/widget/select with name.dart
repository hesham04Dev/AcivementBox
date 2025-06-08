import 'package:flutter/material.dart';

import '../../../models/PrimaryContainer.dart';
class Select extends StatefulWidget {
  Select(
      {super.key,
      required this.length,
      required this.label,
      this.selected = 1});

  final int length;
  final String label;

  int selected;
  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  @override
  Widget build(BuildContext context) {
    Set<int> selected = {widget.selected};
    return PrimaryContainer(
        paddingHorizontal: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${widget.label}: "),
            Center(
              child: Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: SegmentedButton(
                  segments: List.generate(
                      widget.length,
                      (i) =>
                          ButtonSegment(label: Text("${i + 1}"), value: i + 1)),
                  selected: selected,
                  onSelectionChanged: (Set<int> chosen) {
                    widget.selected = chosen.first;
                    setState(() {});
                  },
                  showSelectedIcon: false,
                ),
              ),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';

class Select extends StatefulWidget {
  Select({super.key, required this.length, required this.label});

  final int length;
  final String label;
  int clickedIndex = 0;

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  Set<int> selected = {1};

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).primaryColor.withOpacity(0.2)),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.label}: "),
              Center(
                child: Container(
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: SegmentedButton(
                    segments: List.generate(
                        widget.length,
                        (i) => ButtonSegment(
                            label: Text("${i + 1}"), value: i + 1)),
                    selected: selected,
                    onSelectionChanged: (Set<int> p0) {
                      selected = p0;
                      setState(() {});
                    },
                    showSelectedIcon: false,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

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
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).primaryColor.withOpacity(0.2)),
        child: Container(
          height: 50,
          child: Row(
            children: [
              Text("${widget.label}: "),
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  child: ListView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        widget.length,
                        (index) => Container(
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: widget.clickedIndex == index
                                    ? Colors.black12
                                    : null,
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.clickedIndex = index;
                                    });
                                  },
                                  child: Text("${index + 1}")),
                            )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

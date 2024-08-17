import 'package:flutter/material.dart';

class MyGridView extends StatelessWidget {
  final int itemCount;
  final Function itemBuilder;
  const MyGridView(
      {super.key, required this.itemBuilder, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemBuilder: (context, index) => itemBuilder(context, index),
        itemCount: itemCount,
        shrinkWrap: false,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 110 / 150,
            maxCrossAxisExtent: 120,
            mainAxisExtent: 160));
  }
}

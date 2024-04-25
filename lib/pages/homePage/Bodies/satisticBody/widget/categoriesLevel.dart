import 'package:achivement_box/models/PrimaryContainer.dart';
import 'package:flutter/material.dart';

import '../../../../../models/imageIcon.dart';
import '../../../../../models/levelBar.dart';

class CategoriesLevel extends StatelessWidget {
  const CategoriesLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: Column(
          children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: [
              IconImage(
                path: "assets/icons/gear.png",
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text("math"),
              Expanded(child: SizedBox()),
              LevelBar(
                canChange: false,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

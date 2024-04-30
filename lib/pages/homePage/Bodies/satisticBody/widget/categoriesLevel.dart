import 'package:achivement_box/models/PrimaryContainer.dart';
import 'package:achivement_box/rootProvider/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/imageIcon.dart';
import '../../../../../models/levelBar.dart';

class CategoriesLevel extends StatelessWidget {
  const CategoriesLevel({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> x = context.watch<CategoryProvider>().Category;
    return PrimaryContainer(
      child: Column(
          children: List.generate(
        x.length,
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
              Text(x[index]['Name']),
              Expanded(child: SizedBox()),
              LevelBar(
                categoryName: x[index]['Name'],
                canChange: false,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

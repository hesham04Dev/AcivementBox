import 'package:achivement_box/models/PrimaryContainer.dart';
import 'package:achivement_box/output/generated/icon_names.dart';
import 'package:achivement_box/pages/AddNewPages/newCategory.dart';
import 'package:achivement_box/rootProvider/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/imageIcon.dart';
import '../../../../../models/levelBar.dart';

class CategoriesLevel extends StatelessWidget {
  CategoriesLevel({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> category = context.watch<CategoryProvider>().Category;
    return PrimaryContainer(
      opacity: 0.1,
      padding: 15,
      child: Column(children: [
        SizedBox(
          height: 10,
        ),
        ...List.generate(
          category.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                IconImage(
                  iconName: iconNames[category[index]['IconId']],
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(category[index]['Name']),
                Expanded(child: SizedBox()),
                LevelBar(
                  categoryName: category[index]['Name'],
                  canChange: false,
                ),
              ],
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewCategoryPage()));
            },
            child: Text("new category"))
      ]),
    );
  }
}

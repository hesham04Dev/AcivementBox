
import 'package:flutter/material.dart';
import "package:localization_lite/translate.dart";

import 'package:provider/provider.dart';

import '../../../../../models/imageIcon.dart';
import '../../../../../models/levelBar.dart';
import '../../../../../rootProvider/categoryProvider.dart';
import '../../../../../config/styles.dart';
import '../../../../../models/PrimaryContainer.dart';
import '../../../../../output/generated/icon_names.dart';
import '../../../../../pages/AddNewPages/newCategory.dart';
import '../../../../../pages/EditPages/editCategoriesPage.dart';

class CategoriesLevel extends StatelessWidget {
  const CategoriesLevel({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> category = context.watch<CategoryProvider>().Category;
    return PrimaryContainer(
      opacity: 0.1,
      padding: 15,
      child: Column(children: [
        Text(
          tr("categories"),
          style: titleStyle(context),
        ),
        const SizedBox(
          height: 10,
        ),
        ...List.generate(
          category.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: GestureDetector(
              onLongPress: () {
                if (index > 0) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return EditCategoriesPage(
                      categoryId: category[index]['Id'],
                      categoryName: category[index]['Name'],
                      categoryIcon: category[index]['IconId'],
                    );
                  }));
                }
              },
              child: Row(
                children: [
                  IconImage(
                    iconName: iconNames[category[index]['IconId']],
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(category[index]['Name']),
                  const Expanded(child: SizedBox()),
                  LevelBar(
                    categoryName: category[index]['Name'],
                    canChange: false,
                  ),
                ],
              ),
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewCategoryPage()));
            },
            child: Text(tr("newCategory")))
      ]),
    );
  }
}

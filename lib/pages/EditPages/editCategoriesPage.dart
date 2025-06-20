import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db/db.dart';
import '../../output/generated/icon_names.dart';
import '../../rootProvider/categoryProvider.dart';
import '../AddNewPages/widget/icon.dart';
import '../../pages/AddNewPages/newCategory.dart';

class EditCategoriesPage extends NewCategoryPage {
  final int categoryId;
  final String categoryName;
  final int categoryIcon;
  EditCategoriesPage(
      {super.key,
      required this.categoryId,
      required this.categoryName,
      required this.categoryIcon});

  @override
  State<NewCategoryPage> createState() => _EditCategoryPageState(
      categoryIcon: categoryIcon,
      categoryName: categoryName,
      categoryId: categoryId);
}

class _EditCategoryPageState extends NewCategoryPageState {
  _EditCategoryPageState(
      {required this.categoryId,
      required this.categoryName,
      required this.categoryIcon});
  final int categoryId;
  final String categoryName;
  final int categoryIcon;
  @override
  void initState() {
    super.initState();

    super.name.text = categoryName;

    super.selectIcon = SelectIcon(
      selectedIconName: iconNames[categoryIcon],
    );
    selectIcon.selectedIconId = categoryId;
  }

  @override
  Widget build(BuildContext context) {
    widget.actions = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: () {
              db.sql.categories.delete(id: categoryId);
              context.read<CategoryProvider>().categoryUpdated();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete)),
      )
    ];

    return super.build(context);
  }

  @override
  void save(BuildContext context) {
    db.sql.categories.update(
        id: categoryId,
        iconId: selectIcon.selectedIconId ?? 0,
        name: super.name.text);
    context.read<CategoryProvider>().categoryUpdated();
    Navigator.pop(context);
  }
}

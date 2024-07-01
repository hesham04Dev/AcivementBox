/*import 'package:achivement_box/pages/AddNewPages/newCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Category.dart';
import '../../output/generated/icon_names.dart';
import '../../rootProvider/categoryProvider.dart';
import '../AddNewPages/widget/icon.dart';

class EditCategoriesPage extends NewCategoryPage {
  final Category category;
  const EditCategoriesPage({super.key, required this.category});

  @override
  State<NewCategoryPage> createState() =>
      _EditCategoryPageState(category: category);
}

class _EditCategoryPageState extends NewCategoryPageState {
  _EditCategoryPageState({required this.category});
  final category;
  @override
  void initState() {
    super.initState();

    super.name.text = category.name;

    super.selectIcon = SelectIcon(
      selectedIconName: iconNames[category.iconId],
    );
    selectIcon.selectedIconId = category.iconId;
  }

  @override
  void save(BuildContext context) {
    if (super.formKey.currentState!.validate()) {
      Category h = Category(
        id: category.id,
        name: super.name.text,
        iconId: selectIcon.selectedIconId ?? NewCategoryPage.categoryIconId,
        colorId: 0,
        earnedXp: category.earnedXp,
        level: category.level,
        maxXp: category.maxXp,
      );
      updateCategory(h);
      context.read<CategoryProvider>().categoryUpdated();
      Navigator.pop(context);
    }
  }
}*/


import 'package:flutter/material.dart';
import "package:localization_lite/translate.dart";

import 'package:provider/provider.dart';
import 'package:sqlite3/common.dart';

import '../../../models/PrimaryContainer.dart';
import '../../../rootProvider/categoryProvider.dart';

class CategoryDropDown extends StatelessWidget {
  final TextEditingController controller;
  CategoryDropDown({super.key, required this.controller});
  late int selectedId;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> categoryList = [];
    ResultSet result = context.watch<CategoryProvider>().Category;
    selectedId = result[0]['Id'];
    for (var row in result) {
      categoryList.add(DropdownMenuEntry(value: row['Id'], label: row['Name']));
    }

    return PrimaryContainer(
      padding: 0,
      width: 150,
      height: 50,
      paddingHorizontal: 10,
      child: DropdownMenu(
          width: 130,
          controller: controller,
          onSelected: (value) {
            selectedId = value;
          },
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
          ),
          hintText: tr("category"),
          label: Text(
            tr("category"),
            style: const TextStyle(fontSize: 14),
          ),
          dropdownMenuEntries: categoryList),
    );
  }
}

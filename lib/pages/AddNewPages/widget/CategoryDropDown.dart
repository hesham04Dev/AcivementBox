import 'package:achivement_box/models/PrimaryContainer.dart';
import 'package:achivement_box/rootProvider/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3/common.dart';

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
      paddingHorizontal: 10,
      child: DropdownMenu(
          controller: controller,
          onSelected: (value) {
            selectedId = value;
          },
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
          ),
          hintText: "Category",
          label: const Text(
            "Category",
            style: TextStyle(fontSize: 14),
          ),
          dropdownMenuEntries: categoryList),
    );
  }
}

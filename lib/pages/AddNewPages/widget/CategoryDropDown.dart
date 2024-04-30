import 'package:achivement_box/rootProvider/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3/common.dart';

class CategoryDropDown extends StatelessWidget {
  CategoryDropDown({
    super.key,
  });
  late int selectedId;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> categoryList = [];
    ResultSet result = context.watch<CategoryProvider>().Category;
    selectedId = result[0]['Id'];
    for (var row in result) {
      categoryList.add(DropdownMenuEntry(value: row['Id'], label: row['Name']));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).primaryColor.withOpacity(0.2)),
      child: DropdownMenu(
          onSelected: (value) {
            selectedId = value;
          },
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
          ),
          hintText: "Category",
          label: const Text("Category"),
          dropdownMenuEntries: categoryList),
    );
  }
}

import 'package:achivement_box/rootProvider/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3/common.dart';

class CategoryDropDown extends StatefulWidget {
  const CategoryDropDown({super.key});

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> categoryList = [];
    ResultSet x = context.watch<CategoryProvider>().Category;
    for (var row in x) {
      categoryList.add(DropdownMenuEntry(value: row['id'], label: row['Name']));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).primaryColor.withOpacity(0.2)),
      child: DropdownMenu(
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
          ),
          hintText: "Category",
          label: const Text("Category"),
          dropdownMenuEntries: categoryList),
    );
  }
}

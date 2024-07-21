import 'package:achivement_box/models/AutoDirectionTextFormField.dart';
import 'package:achivement_box/pages/AddNewPages/widget/icon.dart';
import 'package:achivement_box/rootProvider/categoryProvider.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db/sql.dart';

class NewCategoryPage extends StatefulWidget {
  NewCategoryPage({super.key});

  static const int categoryIconId = 0;
  List<Widget>? actions;
  @override
  State<NewCategoryPage> createState() => NewCategoryPageState();
}

class NewCategoryPageState extends State<NewCategoryPage> {
  final TextEditingController name = TextEditingController();
  late SelectIcon selectIcon;

  void save(BuildContext context) {
    if (name.text.isNotEmpty) {
      try {
        newCategory(
            name: name.text,
            iconId: selectIcon.selectedIconId ?? NewCategoryPage.categoryIconId,
            colorId: 1);
        context.read<CategoryProvider>().newCategory();
        Navigator.pop(context);
      } catch (e) {
        CherryToast.error(
          title: const Text("you already have this category"),
          animationType: AnimationType.fromTop,
          displayCloseButton: false,
        ).show(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    selectIcon = SelectIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("new Category"),
        actions: widget.actions,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                child: Column(
              children: [
                selectIcon,
                const SizedBox(
                  height: 10,
                ),
                AutoDirectionTextFormField(
                    controller: name,
                    errMessage: "errMessage",
                    hintText: "name"),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    save(context);
                  },
                  child: const Text("save"),
                  //color: Theme.of(context).primaryColor.withOpacity(0.5),
                )
              ],
            )),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }
}

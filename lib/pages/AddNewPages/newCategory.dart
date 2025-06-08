import '../../rootProvider/categoryProvider.dart';
import '../../models/AutoDirectionTextFormField.dart';
import '../../models/my_toast.dart';
import 'widget/icon.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:localization_lite/translate.dart';
import 'package:provider/provider.dart';

import '../../db/db.dart';

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
        db.sql.categories.add(
          name: name.text,
          iconId: selectIcon.selectedIconId ?? NewCategoryPage.categoryIconId,
        );
        context.read<CategoryProvider>().newCategory();
        Navigator.pop(context);
      } catch (e) {
        print(e);
        MyToast(
          title: Text(tr("youAlreadyHaveThisCategory")),
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
        title: Text(tr("newCategory")),
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
                    errMessage: tr("errMessage"),
                    hintText: tr("name")),
                const SizedBox(
                  height: 10,
                ),
                //...children,
                TextButton(
                  onPressed: () {
                    save(context);
                  },
                  child: Text(tr("save")),
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

import 'package:achivement_box/models/AutoDirectionTextFormField.dart';
import 'package:achivement_box/pages/AddNewPages/widget/icon.dart';
import 'package:achivement_box/rootProvider/categoryProvider.dart';
import 'package:achivement_box/rootProvider/iconProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db.dart';

class NewCategoryPage extends StatelessWidget {
  const NewCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("new Category"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                child: Column(
              children: [
                SelectIcon(),
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
                    if (name.text.isNotEmpty) {
                      newCategory(
                          name: name.text,
                          iconId: context.read<IconProvider>().IconId,
                          colorId: 1);
                    }
                    context.read<CategoryProvider>().newCategory();
                    Navigator.pop(context);
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
}

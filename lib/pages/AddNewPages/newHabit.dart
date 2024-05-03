import 'package:achivement_box/models/AutoDirectionTextFormField.dart';
import 'package:achivement_box/models/mySwitchTile.dart';
import 'package:achivement_box/pages/AddNewPages/newCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db.dart';
import '../../models/select with name.dart';
import '../../rootProvider/habitProvider.dart';
import '../../rootProvider/iconProvider.dart';
import 'widget/CategoryDropDown.dart';
import 'widget/NumericField.dart';
import 'widget/icon.dart';

class NewHabitPage extends StatelessWidget {
  const NewHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController coins = TextEditingController();
    final TextEditingController time = TextEditingController();
    final priority = Select(
      label: "priority",
      length: 5,
    );
    final hardness = Select(
      label: "hardness",
      length: 5,
    );
    final isBad = MySwitchTile(title: "Is Bad?");
    final categoryDropDown = CategoryDropDown();
    return Scaffold(
      appBar: AppBar(
        title: const Text("new habit"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    categoryDropDown,
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NewCategoryPage()));
                      },
                      child: const Text("new category"),
                    )
                  ],
                ),
                priority,
                hardness,
                NumericField(
                  controller: coins,
                  hintText: "Coins",
                ),
                NumericField(
                  controller: time,
                  hintText: "Time in minute",
                ),
                const SizedBox(
                  height: 10,
                ),
                isBad,
                TextButton(
                  onPressed: () {
                    if (name.text.isNotEmpty && coins.text.isNotEmpty) {
                      newHabit(
                          name: name.text,
                          category: categoryDropDown.selectedId,
                          isBad: isBad.value,
                          price: int.parse(coins.text),
                          iconId: context.read<IconProvider>().IconId,
                          priority: priority.clickedIndex + 1,
                          hardness: hardness.clickedIndex + 1,
                          timeInMinutes: int.parse(time.text));
                    }

                    context.read<HabitProvider>().newHabit();
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

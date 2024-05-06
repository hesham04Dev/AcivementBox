import 'package:achivement_box/models/AutoDirectionTextFormField.dart';
import 'package:achivement_box/models/imageIcon.dart';
import 'package:achivement_box/models/mySwitchTile.dart';
import 'package:achivement_box/pages/AddNewPages/newCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db/sql.dart';
import '../../rootProvider/habitProvider.dart';
import '../../rootProvider/iconProvider.dart';
import 'widget/CategoryDropDown.dart';
import 'widget/NumericField.dart';
import 'widget/icon.dart';
import 'widget/select with name.dart';

class NewHabitPage extends StatelessWidget {
  const NewHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController coins = TextEditingController();
    final TextEditingController time = TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
        leading: Transform.rotate(
          angle: -3.14 / 2,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconImage(
              iconName: "arrow-up-to-arc.png",
              size: 30,
            ),
          ),
        ),
        title: const Text("new habit"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SelectIcon(),
                    const SizedBox(
                      height: 10,
                    ),
                    AutoDirectionTextFormField(
                        controller: name,
                        errMessage: "please enter a name",
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
                      maxValue: 10000,
                    ),
                    NumericField(
                      controller: time,
                      hintText: "Time in minute",
                      maxValue: 24 * 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    isBad,
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          newHabit(
                              name: name.text,
                              category: categoryDropDown.selectedId,
                              isBad: isBad.value,
                              price: int.parse(coins.text),
                              iconId: context.read<IconProvider>().IconId,
                              priority: priority.clickedIndex + 1,
                              hardness: hardness.clickedIndex + 1,
                              timeInMinutes: int.parse(time.text));

                          context.read<HabitProvider>().newHabit();
                          Navigator.pop(context);
                        }
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
//TODO max of the habit price is the maxXp * 2

import 'package:achivement_box/models/AutoDirectionTextFormField.dart';
import 'package:achivement_box/models/mySwitchTile.dart';
import 'package:achivement_box/pages/AddNewPages/newCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db/sql.dart';
import '../../rootProvider/habitProvider.dart';
import 'widget/CategoryDropDown.dart';
import 'widget/NumericField.dart';
import 'widget/icon.dart';
import 'widget/select with name.dart';

class NewHabitPage extends StatefulWidget {
  NewHabitPage({super.key});
  List<Widget>? actions;
  static const int gearIconId = 39;

  @override
  State<NewHabitPage> createState() => NewHabitPageState();
}

class NewHabitPageState extends State<NewHabitPage> {
  late final TextEditingController name;
  late final TextEditingController coins;
  late final TextEditingController time;
  late final TextEditingController category;
  late final GlobalKey<FormState> formKey;
  late final Select priority;
  late final Select hardness;
  late final MySwitchTile isBad;
  late SelectIcon selectIcon;
  late final CategoryDropDown categoryDropDown;

  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      newHabit(
          name: name.text,
          category: categoryDropDown.selectedId,
          isBad: isBad.value,
          price: int.parse(coins.text),
          iconId: selectIcon.selectedIconId ?? NewHabitPage.gearIconId,
          priority: priority.selected,
          hardness: hardness.selected,
          timeInMinutes: int.parse(time.text));

      context.read<HabitProvider>().newHabit();
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    name = TextEditingController();
    coins = TextEditingController();
    time = TextEditingController();
    category = TextEditingController();
    formKey = GlobalKey<FormState>();
    priority = Select(
      label: "priority",
      length: 5,
    );
    hardness = Select(
      label: "hardness",
      length: 5,
    );
    isBad = MySwitchTile(title: "Is Bad?");
    categoryDropDown = CategoryDropDown(
      controller: category,
    );
    selectIcon = SelectIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("new habit"),
        actions: widget.actions,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    selectIcon,
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
                                    builder: (_) => NewCategoryPage()));
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
    time.dispose();
    coins.dispose();
    name.dispose();
    super.dispose();
  }
}

import 'package:achivement_box/models/AutoDirectionTextFormField.dart';
import 'package:achivement_box/pages/homePage/provider/habitProvider.dart';
import 'package:achivement_box/pages/newHabit/widget/isBad.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db.dart';
import '../../models/select with name.dart';

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
    final isBad = IsBad();
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
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Theme.of(context).primaryColor.withOpacity(0.1)),
                    child: const Icon(Icons.add)),
                const SizedBox(
                  height: 10,
                ),
                AutoDirectionTextFormField(
                    controller: name,
                    errMessage: "errMessage",
                    hintText: "name"),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  child: const DropdownMenu(
                      inputDecorationTheme: InputDecorationTheme(
                        border: InputBorder.none,
                      ),
                      hintText: "Category",
                      label: Text("Category"),
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: 1, label: "label")
                        //TODO auto generated with data from cat table
                      ]),
                ),

                /*SegmentedButton(
                    segments: [ButtonSegment(value: 1)], selected: Set()),*/
                Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColor.withOpacity(0.2)),
                    child: priority),
                Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColor.withOpacity(0.2)),
                    child: hardness),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  child: TextFormField(
                    controller: coins,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter a number";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Coins", border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  child: TextFormField(
                    controller: time,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter a number";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Time in minute", border: InputBorder.none),
                  ),
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
                          category: 0,
                          isBad: isBad.value,
                          price: int.parse(coins.text),
                          iconId: 1,
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
//TODO category and icon

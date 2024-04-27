import 'package:achivement_box/models/AutoDirectionTextFormField.dart';
import 'package:achivement_box/pages/homePage/provider/habitProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db.dart';
import '../models/select with name.dart';

class NewHabitPage extends StatelessWidget {
  const NewHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController coins = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("new habit"),
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
                        borderRadius: BorderRadius.circular(50),
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  child: DropdownMenu(
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
                Container(
                  margin: const EdgeInsets.all(5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  child: Select(
                    label: "priority",
                    length: 5,
                  ),
                ),
                /*SegmentedButton(
                    segments: [ButtonSegment(value: 1)], selected: Set()),*/
                Container(
                  margin: const EdgeInsets.all(5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  child: Select(
                    label: "hardness",
                    length: 5,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                    decoration: InputDecoration(
                        hintText: "Coins", border: InputBorder.none),
                  ),
                ),
                SwitchListTile(
                    title: const Text("Is Bad? "),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide.none),
                    value: false,
                    onChanged: (value) {}),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    if (name.text.isNotEmpty && coins.text.isNotEmpty)
                      newHabit(
                          name: name.text,
                          category: 0,
                          isBad: false,
                          price: int.parse(coins.text),
                          iconId: 1,
                          priority: 5,
                          hardness: 5,
                          timeInMinutes: 10);
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

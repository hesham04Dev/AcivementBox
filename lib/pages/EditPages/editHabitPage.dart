import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db/sql.dart';
import '../../models/habit.dart';
import '../../output/generated/icon_names.dart';
import '../../rootProvider/habitProvider.dart';
import '../AddNewPages/newHabit.dart';
import '../AddNewPages/widget/icon.dart';

class EditHabitsPage extends NewHabitPage {
  final Habit habit;
  EditHabitsPage({required this.habit});

  @override
  State<NewHabitPage> createState() => _EditHabitPageState(habit: habit);
}

class _EditHabitPageState extends NewHabitPageState {
  final Habit habit;
  _EditHabitPageState({required this.habit});
  @override
  void initState() {
    super.initState();

    super.name.text = habit.name;

    super.coins.text = "${habit.price}";
    super.category.text = "${getCategory(habit.categoryId)['Name']}";
    super.categoryDropDown.selectedId = habit.categoryId;
    super.time.text = "${habit.timeInMinutes}";
    super.hardness.clickedIndex = habit.hardness - 1;
    super.priority.clickedIndex = habit.priority - 1;
    super.isBad.value = habit.isBadHabit;

    super.selectIcon = SelectIcon(
      selectedIconName: iconNames[habit.iconId],
    );
    super.selectIcon.selectedIconId = habit.iconId;
  }

  @override
  void save(BuildContext context) {
    if (super.formKey.currentState!.validate()) {
      Habit h = Habit(
        id: habit.id,
        name: super.name.text,
        categoryId: super.categoryDropDown.selectedId,
        isBadHabit: super.isBad.value,
        price: int.parse(super.coins.text),
        iconId: selectIcon.selectedIconId ?? NewHabitPage.gearIconId,
        priority: super.priority.clickedIndex + 1,
        hardness: super.hardness.clickedIndex + 1,
        timeInMinutes: int.parse(super.time.text),
        totalTimes: habit.totalTimes,
        context: context,
      );
      updateHabit(h);
      context.read<HabitProvider>().habitUpdated();
      Navigator.pop(context);
    }
  }
}

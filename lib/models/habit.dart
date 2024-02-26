import 'tileWithCounter.dart';

class Habit extends TileWithCounter {
  final bool isBadHabit;
  final int priority;
  final int hardness;
  final List<String> categories;

  void openEditPage() {
    // TODO habit edit page
  }

  void clicked() {
    if (isBadHabit) {
      //TODO remove price from the coins
    }
    // base level add  priority * 2 + hardness
    // the same for the category level but is devided for the number of the categories in
    //show a toast with the exp gained
    //TODO provide this to the coins by provider
  }

  Habit(
      {required super.icon,
      required super.name,
      required super.price,
      required this.categories,
      required this.isBadHabit,
      required this.priority,
      required this.hardness});
}

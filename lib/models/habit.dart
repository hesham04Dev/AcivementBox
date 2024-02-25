import 'tileWithCounter.dart';

class Habit extends TileWithCounter {
  /*static Function Clicked = (num price) {

  };
  static Function OpenEditPage = () {

  };*/
  final bool isBadHabit;
  final int priority;
  final int hardness;
  void openEditPage() {
    // TODO habit edit page
  }
  void clicked() {
    //TODO provide this to the coins by provider
  }
  Habit(
      {required super.icon,
      required super.name,
      required super.price,
      required this.isBadHabit,
      required this.priority,
      required this.hardness})
      : super(/*openEditPage: OpenEditPage, clicked: Clicked*/);
}

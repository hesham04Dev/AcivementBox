import 'tileWithCounter.dart';

class Gift extends TileWithCounter {
  static Function Clicked = (num price) {
    //TODO provide this to the coins by provider
    //TODO alert a message to undo buying this gift
    aa(price);
  };
  void aa(price) {
    //TODO return this to the coins
  }
  static Function OpenEditPage = () {
    // TODO gift edit page note no remove on this
  };

  Gift({
    required super.icon,
    required super.name,
    required super.price,
  }) : super(openEditPage: OpenEditPage, clicked: Clicked);
}

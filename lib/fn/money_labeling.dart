String labelMoney(int money) {
  String label = "";
  if (money > 1000) {
    money = (money / 1000).round();
    label = "K";
  } else if (money > 1000000) {
    money = (money / 1000000).round();
    label = "M";
  }
  return "$money$label";
}

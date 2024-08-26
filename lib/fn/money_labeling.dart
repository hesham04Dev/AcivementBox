String labelMoney(int money) {
  bool isNegative = false;
  if (money < 0) {
    isNegative = true;
    money *= -1;
  }
  String label = "";
  if (money > 1000) {
    money = (money / 1000).round();
    label = "K";
  } else if (money > 1000000) {
    money = (money / 1000000).round();
    label = "M";
  }
  return isNegative ? "-$money$label" : "$money$label";
}

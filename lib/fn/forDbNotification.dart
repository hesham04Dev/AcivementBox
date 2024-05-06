int formatToSet(int hour, int minute) {
  if (minute < 10) {
    return int.parse("${hour}0$minute");
  } else {
    return (int.parse("$hour$minute"));
  }
}

String formatToGet(int hoursMinutes) {
  String x = hoursMinutes.toString();
  if (x == "0") {
    return "0:00";
  } else if (x.length > 3) {
    return "${x.substring(0, 1)}:${x.substring(2)}";
  } else
    return "${x.substring(0, 0)}:${x.substring(1)}";
}

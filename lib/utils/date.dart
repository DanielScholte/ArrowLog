class DateUtil {
  static int getDayValue(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day).millisecondsSinceEpoch ~/ 86400000;
  }
}
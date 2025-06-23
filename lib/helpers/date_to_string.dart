import 'package:intl/intl.dart' show DateFormat;

//convertir una fecha a String

class DateHelper {
  static String addValueToDate(String value, {int day = 0}) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(value);
    date = date.add(Duration(
      days: day,
    ));
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String dateToString(date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String dateTimeToString(date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  static String timeToString(date) {
    return DateFormat('HH:mm').format(date);
  }
}

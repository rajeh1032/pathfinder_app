import 'package:intl/intl.dart';

class DateFormatter {
  const DateFormatter._();

  static String format(DateTime dateTime) => DateFormat.yMMMd().format(dateTime);
}

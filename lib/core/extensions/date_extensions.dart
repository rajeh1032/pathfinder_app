import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String toReadableDate() => DateFormat.yMMMd().format(this);
}

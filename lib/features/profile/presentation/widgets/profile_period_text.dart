import 'package:easy_localization/easy_localization.dart';

/// Formats a start/end date range for display, e.g. "2021 – 2025" or
/// "2025 – Present". Dates arrive as 'YYYY-MM-DD' strings.
String formatProfilePeriod({
  String? startDate,
  String? endDate,
  bool isCurrent = false,
}) {
  final start = _year(startDate);
  final end = isCurrent ? 'profile.present'.tr() : _year(endDate);

  if (start == null && end == null) return '';
  if (start == null) return end ?? '';
  if (end == null || end.isEmpty) return start;
  return '$start – $end';
}

String? _year(String? date) {
  if (date == null || date.trim().isEmpty) return null;
  final parts = date.split('-');
  return parts.isNotEmpty ? parts.first : date;
}

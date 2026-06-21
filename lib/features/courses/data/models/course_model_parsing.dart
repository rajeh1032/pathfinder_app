Map<String, dynamic> requiredMap(Object? value, String name) {
  if (value is Map<String, dynamic>) return value;
  throw FormatException('Invalid or missing $name');
}

String requiredString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is String && value.trim().isNotEmpty) return value.trim();
  throw FormatException('Invalid or missing $key');
}

String? nullableString(Object? value) {
  if (value == null) return null;
  if (value is String) return value.trim().isEmpty ? null : value.trim();
  throw const FormatException('Expected nullable string');
}

bool requiredBool(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is bool) return value;
  throw FormatException('Invalid or missing $key');
}

num? numberValue(Object? value) {
  if (value == null || value == '') return null;
  if (value is num) return value;
  if (value is String) return num.tryParse(value);
  return null;
}

double? nullableDouble(Object? value) {
  if (value == null) return null;
  final parsed = numberValue(value);
  if (parsed == null) throw const FormatException('Invalid number');
  return parsed.toDouble();
}

int requiredInt(Map<String, dynamic> json, String key, {int? min}) {
  final parsed = numberValue(json[key]);
  if (parsed == null || parsed % 1 != 0) {
    throw FormatException('Invalid or missing $key');
  }
  final value = parsed.toInt();
  if (min != null && value < min) throw FormatException('Invalid $key');
  return value;
}

List<dynamic> requiredList(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is List) return value;
  throw FormatException('Invalid or missing $key');
}

List<String> stringList(Map<String, dynamic> json, String key) =>
    requiredList(json, key).map((item) {
      if (item is String && item.trim().isNotEmpty) return item.trim();
      throw FormatException('Invalid $key item');
    }).toList(growable: false);

DateTime? nullableDate(Object? value) {
  final text = nullableString(value);
  if (text == null) return null;
  final date = DateTime.tryParse(text);
  if (date == null) throw const FormatException('Invalid date');
  return date;
}

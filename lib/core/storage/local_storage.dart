import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  const LocalStorage._();

  static late final SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String? getString(String key) => _preferences.getString(key);

  static Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  static Future<bool> remove(String key) => _preferences.remove(key);
}

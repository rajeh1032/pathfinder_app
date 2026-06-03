import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationService {
  const LocalizationService._();

  static const translationsPath = 'assets/translations';
  static const english = Locale('en');
  static const arabic = Locale('ar');
  static const supportedLocales = [english, arabic];

  static Future<void> setLocale(BuildContext context, Locale locale) {
    return context.setLocale(locale);
  }

  static bool isRtl(Locale locale) => locale.languageCode == arabic.languageCode;
}

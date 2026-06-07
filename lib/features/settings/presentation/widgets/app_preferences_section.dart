import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/localization_service.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_theme_cubit.dart';
import 'settings_section.dart';

class AppPreferencesSection extends StatelessWidget {
  const AppPreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      icon: Icons.tune_outlined,
      titleKey: 'settings.preferences',
      children: [
        SettingsTile(
          leading: const Icon(Icons.palette_outlined),
          titleKey: 'settings.theme',
          subtitleKey: _themeLabelKey(context.watch<AppThemeCubit>().state),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, AppRoutes.themeSettings),
        ),
        const SettingsDivider(),
        SettingsTile(
          leading: const Icon(Icons.language_outlined),
          titleKey: 'settings.language',
          subtitleKey: _languageLabelKey(context.locale),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, AppRoutes.languageSettings),
        ),
      ],
    );
  }

  String _themeLabelKey(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => 'settings.themeLight',
      ThemeMode.dark => 'settings.themeDark',
      ThemeMode.system => 'settings.themeSystem',
    };
  }

  String _languageLabelKey(Locale locale) {
    if (locale.languageCode == LocalizationService.arabic.languageCode) {
      return 'settings.languageArabic';
    }
    return 'settings.languageEnglish';
  }
}

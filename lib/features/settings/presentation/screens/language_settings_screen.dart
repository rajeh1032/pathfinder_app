import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/localization_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../widgets/settings_section.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeCode = context.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text('settings.language'.tr()),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            SettingsSection(
              icon: Icons.language_outlined,
              titleKey: 'settings.language',
              children: [
                _LanguageOption(
                  titleKey: 'settings.languageEnglish',
                  selected:
                      localeCode == LocalizationService.english.languageCode,
                  onTap: () => _setLocale(context, LocalizationService.english),
                ),
                const SettingsDivider(),
                _LanguageOption(
                  titleKey: 'settings.languageArabic',
                  selected:
                      localeCode == LocalizationService.arabic.languageCode,
                  onTap: () => _setLocale(context, LocalizationService.arabic),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setLocale(BuildContext context, Locale locale) async {
    await LocalizationService.setLocale(context, locale);
    if (!context.mounted) return;
    CustomSnackbar.showSuccessKey(
        context: context, messageKey: 'settings.saved');
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.titleKey,
    required this.selected,
    required this.onTap,
  });

  final String titleKey;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      leading: const Icon(Icons.translate_outlined),
      titleKey: titleKey,
      trailing: selected
          ? Icon(Icons.check_circle,
              color: Theme.of(context).colorScheme.primary)
          : const Icon(Icons.circle_outlined),
      onTap: onTap,
    );
  }
}

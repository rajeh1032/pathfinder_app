import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/localization_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme_cubit.dart';
import 'profile_preference_card.dart';

class ProfilePreferencesSection extends StatelessWidget {
  const ProfilePreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePreferenceCard(
          icon: Icons.language_outlined,
          title: context.tr('profile.languageTitle'),
          value: _languageLabel(context),
          buttonLabel: context.tr('profile.changeLanguage'),
          onPressed: () => _showLanguageSheet(context),
        ),
        const SizedBox(height: AppSpacing.md),
        ProfilePreferenceCard(
          icon: Icons.palette_outlined,
          title: context.tr('profile.themeTitle'),
          value: _themeLabel(context, context.watch<AppThemeCubit>().state),
          buttonLabel: context.tr('profile.changeTheme'),
          onPressed: () => _showThemeSheet(context),
        ),
      ],
    );
  }

  String _languageLabel(BuildContext context) {
    if (context.locale.languageCode ==
        LocalizationService.arabic.languageCode) {
      return context.tr('profile.languageArabic');
    }

    return context.tr('profile.languageEnglish');
  }

  String _themeLabel(BuildContext context, ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => context.tr('profile.themeLight'),
      ThemeMode.dark => context.tr('profile.themeDark'),
      ThemeMode.system => context.tr('profile.themeSystem'),
    };
  }

  Future<void> _showLanguageSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return _OptionsSheet(
          title: context.tr('profile.changeLanguage'),
          children: [
            _OptionTile(
              icon: Icons.translate,
              title: context.tr('profile.languageEnglish'),
              selected: context.locale.languageCode ==
                  LocalizationService.english.languageCode,
              onTap: () async {
                await LocalizationService.setLocale(
                  context,
                  LocalizationService.english,
                );
                if (sheetContext.mounted) Navigator.of(sheetContext).pop();
              },
            ),
            _OptionTile(
              icon: Icons.translate,
              title: context.tr('profile.languageArabic'),
              selected: context.locale.languageCode ==
                  LocalizationService.arabic.languageCode,
              onTap: () async {
                await LocalizationService.setLocale(
                  context,
                  LocalizationService.arabic,
                );
                if (sheetContext.mounted) Navigator.of(sheetContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showThemeSheet(BuildContext context) {
    final cubit = context.read<AppThemeCubit>();

    return showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return _OptionsSheet(
          title: context.tr('profile.changeTheme'),
          children: [
            _OptionTile(
              icon: Icons.brightness_auto_outlined,
              title: context.tr('profile.themeSystem'),
              selected: cubit.state == ThemeMode.system,
              onTap: () {
                cubit.setThemeMode(ThemeMode.system);
                Navigator.of(sheetContext).pop();
              },
            ),
            _OptionTile(
              icon: Icons.light_mode_outlined,
              title: context.tr('profile.themeLight'),
              selected: cubit.state == ThemeMode.light,
              onTap: () {
                cubit.setThemeMode(ThemeMode.light);
                Navigator.of(sheetContext).pop();
              },
            ),
            _OptionTile(
              icon: Icons.dark_mode_outlined,
              title: context.tr('profile.themeDark'),
              selected: cubit.state == ThemeMode.dark,
              onTap: () {
                cubit.setThemeMode(ThemeMode.dark);
                Navigator.of(sheetContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _OptionsSheet extends StatelessWidget {
  const _OptionsSheet({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      trailing: selected
          ? Icon(Icons.check_circle, color: colors.primary)
          : const Icon(Icons.circle_outlined),
      onTap: onTap,
    );
  }
}

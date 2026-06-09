import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme_cubit.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../widgets/settings_section.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text('settings.theme'.tr()),
      ),
      body: SafeArea(
        child: BlocBuilder<AppThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                SettingsSection(
                  icon: Icons.palette_outlined,
                  titleKey: 'settings.theme',
                  children: [
                    _ThemeOption(
                      titleKey: 'settings.themeSystem',
                      icon: Icons.brightness_auto_outlined,
                      selected: mode == ThemeMode.system,
                      onTap: () => _setTheme(context, ThemeMode.system),
                    ),
                    const SettingsDivider(),
                    _ThemeOption(
                      titleKey: 'settings.themeLight',
                      icon: Icons.light_mode_outlined,
                      selected: mode == ThemeMode.light,
                      onTap: () => _setTheme(context, ThemeMode.light),
                    ),
                    const SettingsDivider(),
                    _ThemeOption(
                      titleKey: 'settings.themeDark',
                      icon: Icons.dark_mode_outlined,
                      selected: mode == ThemeMode.dark,
                      onTap: () => _setTheme(context, ThemeMode.dark),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _setTheme(BuildContext context, ThemeMode mode) {
    context.read<AppThemeCubit>().setThemeMode(mode);
    CustomSnackbar.showSuccessKey(
        context: context, messageKey: 'settings.saved');
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.titleKey,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String titleKey;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      leading: Icon(icon),
      titleKey: titleKey,
      trailing: selected
          ? Icon(Icons.check_circle,
              color: Theme.of(context).colorScheme.primary)
          : const Icon(Icons.circle_outlined),
      onTap: onTap,
    );
  }
}

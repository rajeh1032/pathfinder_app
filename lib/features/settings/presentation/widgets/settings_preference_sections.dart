import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../domain/entities/settings_preferences.dart';
import '../cubit/settings_cubit.dart';
import 'settings_section.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({required this.preferences, this.email, super.key});

  final SettingsPreferences preferences;

  /// Real email from the access token; falls back to the demo key when null.
  final String? email;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: .75)),
        boxShadow: AppShadows.card,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Column(
          children: [
            SettingsTile(
              titleKey: 'settings.emailLabel',
              subtitleKey: preferences.emailKey,
              subtitle: (email?.trim().isNotEmpty ?? false) ? email!.trim() : null,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile),
            ),
            const SettingsDivider(),
            SettingsTile(
              titleKey: 'settings.phoneLabel',
              subtitleKey: preferences.phoneKey,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile),
            ),
          ],
        ),
      ),
    );
  }
}

class AiPersonalization extends StatelessWidget {
  const AiPersonalization({required this.preferences, super.key});

  final SettingsPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      icon: Icons.psychology_outlined,
      titleKey: 'settings.aiPersonalization',
      children: [
        SettingsTile(
          titleKey: 'settings.mentorTone',
          subtitleKey: preferences.mentorToneKey,
          trailing: const Icon(Icons.tune_outlined),
          onTap: () => _openAndRefresh(context, AppRoutes.mentorToneSettings),
        ),
        const SettingsDivider(),
        SettingsTile(
          titleKey: 'settings.careerGoalTuning',
          subtitleKey: preferences.careerGoalKey,
          trailing: const Icon(Icons.trending_up_outlined),
          onTap: () => _openAndRefresh(context, AppRoutes.careerGoalSettings),
        ),
        const SettingsDivider(),
        SettingsTile(
          titleKey: 'settings.aiTrainingData',
          subtitleKey: 'settings.aiTrainingHelp',
          trailing: Switch(
            value: preferences.aiTrainingData,
            onChanged: (enabled) =>
                context.read<SettingsCubit>().togglePreference(
                      key: SettingsPreferenceKey.aiTrainingData,
                      enabled: enabled,
                    ),
          ),
        ),
      ],
    );
  }

  Future<void> _openAndRefresh(BuildContext context, String routeName) async {
    await Navigator.pushNamed(context, routeName);
    if (context.mounted) {
      await context.read<SettingsCubit>().loadSettings();
    }
  }
}

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({required this.preferences, super.key});

  final SettingsPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      icon: Icons.notifications_none_outlined,
      titleKey: 'settings.notifications',
      children: [
        SettingsTile(
          leading: const Icon(Icons.keyboard_outlined),
          titleKey: 'settings.pushNotifications',
          trailing: Switch(
            value: preferences.pushNotifications,
            onChanged: (enabled) =>
                context.read<SettingsCubit>().togglePreference(
                      key: SettingsPreferenceKey.pushNotifications,
                      enabled: enabled,
                    ),
          ),
        ),
        const SettingsDivider(),
        SettingsTile(
          leading: const Icon(Icons.mail_outline),
          titleKey: 'settings.emailDigests',
          trailing: Switch(
            value: preferences.emailDigests,
            onChanged: (enabled) =>
                context.read<SettingsCubit>().togglePreference(
                      key: SettingsPreferenceKey.emailDigests,
                      enabled: enabled,
                    ),
          ),
        ),
      ],
    );
  }
}

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      icon: Icons.shield_outlined,
      titleKey: 'settings.security',
      children: [
        SettingsTile(
          leading: const Icon(Icons.key_outlined),
          titleKey: 'settings.changePassword',
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile),
        ),
      ],
    );
  }
}

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      icon: Icons.help_outline,
      titleKey: 'settings.supportLegal',
      children: [
        SettingsTile(
          titleKey: 'settings.helpCenter',
          trailing: const Icon(Icons.open_in_new_outlined),
          onTap: () => Navigator.pushNamed(context, AppRoutes.helpCenter),
        ),
        const SettingsDivider(),
        SettingsTile(
          titleKey: 'settings.privacyPolicy',
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, AppRoutes.privacyPolicy),
        ),
        const SettingsDivider(),
        SettingsTile(
          titleKey: 'settings.termsOfService',
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(context, AppRoutes.termsOfService),
        ),
      ],
    );
  }
}

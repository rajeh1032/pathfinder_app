import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../domain/entities/settings_preferences.dart';
import '../cubit/settings_cubit.dart';
import 'app_preferences_section.dart';
import 'settings_account_card.dart';
import 'settings_actions.dart';
import 'settings_dialogs.dart';
import 'settings_preference_sections.dart';
import 'settings_section.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    required this.preferences,
    required this.isSubmitting,
    super.key,
  });

  final SettingsPreferences preferences;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      children: [
        SettingsSection(
          icon: Icons.account_circle_outlined,
          titleKey: 'settings.account',
          carded: false,
          children: [
            SettingsAccountCard(
              preferences: preferences,
              onEdit: () => Navigator.pushNamed(context, AppRoutes.editProfile),
            ),
            const SizedBox(height: AppSpacing.sm),
            AccountDetails(preferences: preferences),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const AppPreferencesSection(),
        const SizedBox(height: AppSpacing.lg),
        AiPersonalization(preferences: preferences),
        const SizedBox(height: AppSpacing.lg),
        NotificationSettings(preferences: preferences),
        const SizedBox(height: AppSpacing.lg),
        const SecuritySection(),
        const SizedBox(height: AppSpacing.lg),
        const SupportSection(),
        const SizedBox(height: AppSpacing.lg),
        SettingsActions(
          isSubmitting: isSubmitting,
          onSignOut: () => _confirmSignOut(context),
          onDeleteAccount: () => _confirmDeleteAccount(context),
        ),
      ],
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmed = await showSettingsConfirmationDialog(
      context: context,
      titleKey: 'settings.signOutTitle',
      messageKey: 'settings.signOutMessage',
      confirmKey: 'settings.signOut',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final succeeded = await context.read<SettingsCubit>().signOut();
    if (context.mounted && succeeded) {
      CustomSnackbar.showSuccessKey(
        context: context,
        messageKey: 'settings.signedOut',
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final confirmed = await showSettingsConfirmationDialog(
      context: context,
      titleKey: 'settings.deleteAccountTitle',
      messageKey: 'settings.deleteAccountMessage',
      confirmKey: 'settings.deleteAccount',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final succeeded = await context.read<SettingsCubit>().deleteAccount();
    if (context.mounted && succeeded) {
      CustomSnackbar.showSuccessKey(
        context: context,
        messageKey: 'settings.accountDeleted',
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }
}

void showSettingsMessage(BuildContext context, String messageKey) {
  CustomSnackbar.showInfoKey(context: context, messageKey: messageKey);
}

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';

class SettingsActions extends StatelessWidget {
  const SettingsActions({
    required this.isSubmitting,
    required this.onSignOut,
    required this.onDeleteAccount,
    super.key,
  });

  final bool isSubmitting;
  final VoidCallback onSignOut;
  final VoidCallback onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          labelKey: 'settings.signOut',
          icon: Icons.logout_outlined,
          variant: CustomButtonVariant.destructiveSoft,
          onPressed: isSubmitting ? null : onSignOut,
        ),
        const SizedBox(height: AppSpacing.sm),
        CustomButton(
          labelKey: 'settings.deleteAccount',
          icon: Icons.delete_outline,
          variant: CustomButtonVariant.destructiveOutline,
          onPressed: isSubmitting ? null : onDeleteAccount,
        ),
      ],
    );
  }
}

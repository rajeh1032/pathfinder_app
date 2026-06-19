import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/settings_preferences.dart';

class SettingsAccountCard extends StatelessWidget {
  const SettingsAccountCard({
    required this.preferences,
    required this.onEdit,
    super.key,
  });

  final SettingsPreferences preferences;
  final VoidCallback onEdit;

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
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                preferences.avatarAsset,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr(preferences.displayNameKey),
                    style: AppTextStyles.bodyLarge(colors.onSurface),
                  ),
                  Text(
                    context.tr(preferences.headlineKey),
                    style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

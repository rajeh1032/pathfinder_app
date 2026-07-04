import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.icon,
    required this.titleKey,
    required this.children,
    this.carded = true,
    super.key,
  });

  final IconData icon;
  final String titleKey;
  final List<Widget> children;
  final bool carded;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final content = Column(children: children);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: colors.primary, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(
              context.tr(titleKey),
              style: AppTextStyles.titleSmall(colors.onSurface),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (carded)
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: colors.outlineVariant.withValues(alpha: .75),
              ),
              boxShadow: AppShadows.card,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: content,
            ),
          )
        else
          content,
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.titleKey,
    this.subtitleKey,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.centered = false,
    super.key,
  });

  final String titleKey;
  final String? subtitleKey;

  /// Raw (already-resolved) subtitle text. Takes precedence over [subtitleKey].
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppSpacing.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: centered
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr(titleKey),
                    style: AppTextStyles.bodyLarge(colors.onSurface),
                    textAlign: centered ? TextAlign.center : TextAlign.start,
                  ),
                  if (subtitle != null || subtitleKey != null)
                    Text(
                      subtitle ?? context.tr(subtitleKey!),
                      style: AppTextStyles.bodySmall(colors.onSurfaceVariant),
                      textAlign: centered ? TextAlign.center : TextAlign.start,
                    ),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppSpacing.md),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.colors.outlineVariant.withValues(alpha: .55),
    );
  }
}

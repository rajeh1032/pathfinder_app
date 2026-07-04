import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/profile.dart';
import 'profile_section_card.dart';

class ProfileEducationCard extends StatelessWidget {
  const ProfileEducationCard({required this.items, super.key});

  final List<ProfileEducationItem> items;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      icon: Icons.school_outlined,
      titleKey: 'profile.education',
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _EducationTile(item: item),
            ),
          )
          .toList(),
    );
  }
}

class _EducationTile extends StatelessWidget {
  const _EducationTile({required this.item});

  final ProfileEducationItem item;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: item.highlighted
            ? colors.primary.withValues(alpha: .06)
            : colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: item.highlighted
              ? colors.primary.withValues(alpha: .16)
              : colors.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: colors.primaryContainer,
              foregroundColor: colors.primary,
              child: Icon(
                item.highlighted
                    ? Icons.verified_outlined
                    : Icons.account_balance_outlined,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr(item.titleKey),
                    style: AppTextStyles.titleSmall(colors.onSurface),
                  ),
                  Text(
                    context.tr(item.subtitleKey),
                    style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    context.tr(item.metaKey),
                    style: AppTextStyles.labelSmall(
                      item.highlighted
                          ? colors.primary
                          : colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

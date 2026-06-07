import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/profile.dart';
import 'profile_section_card.dart';

class ProfileSkillsCard extends StatelessWidget {
  const ProfileSkillsCard({required this.skillGroups, super.key});

  final List<ProfileSkillGroup> skillGroups;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ProfileSectionCard(
      icon: Icons.psychology_outlined,
      titleKey: 'profile.skillsExpertise',
      children: skillGroups
          .map(
            (group) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.titleKey.tr().toUpperCase(),
                    style: AppTextStyles.labelSmall(colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: group.skillKeys.map(_SkillChip.new).toList(),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip(this.skillKey);

  final String skillKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: colors.primary.withValues(alpha: .22)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Text(
          skillKey.tr(),
          style: AppTextStyles.labelSmall(colors.primary),
        ),
      ),
    );
  }
}

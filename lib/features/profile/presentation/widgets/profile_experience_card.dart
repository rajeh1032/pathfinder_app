import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/profile.dart';
import 'profile_section_card.dart';

class ProfileExperienceCard extends StatelessWidget {
  const ProfileExperienceCard({required this.experiences, super.key});

  final List<ProfileExperience> experiences;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ProfileSectionCard(
      icon: Icons.work_outline,
      titleKey: 'profile.experience',
      children: experiences
          .map(
            (experience) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: const SizedBox(width: 14, height: 14),
                    ),
                    Container(
                      width: 2,
                      height: 180,
                      color: colors.primaryContainer,
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: _ExperienceDetails(experience: experience)),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _ExperienceDetails extends StatelessWidget {
  const _ExperienceDetails({required this.experience});

  final ProfileExperience experience;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr(experience.roleKey),
          style: AppTextStyles.titleSmall(colors.onSurface),
        ),
        Text(
          context.tr(experience.companyKey),
          style: AppTextStyles.bodyMedium(colors.tertiary),
        ),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            child: Text(
              context.tr(experience.periodKey),
              style: AppTextStyles.labelSmall(colors.onSurfaceVariant),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...experience.impactKeys.map(
          (key) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              context.tr(key),
              style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
            ),
          ),
        ),
      ],
    );
  }
}

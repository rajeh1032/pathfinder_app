import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/profile.dart';
import 'profile_section_card.dart';

class ProfileAchievementsCard extends StatelessWidget {
  const ProfileAchievementsCard({required this.achievements, super.key});

  final List<ProfileMetric> achievements;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      icon: Icons.emoji_events_outlined,
      titleKey: 'profile.achievements',
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: achievements.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
          ),
          itemBuilder: (context, index) {
            return _AchievementMetric(metric: achievements[index]);
          },
        ),
      ],
    );
  }
}

class _AchievementMetric extends StatelessWidget {
  const _AchievementMetric({required this.metric});

  final ProfileMetric metric;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            gradient: AppGradients.aiTertiary,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(14.r),
            child: Icon(_iconFor(metric.iconName), color: colors.onPrimary),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          context.tr(metric.valueKey),
          maxLines: 1,
          style: AppTextStyles.labelMedium(colors.onSurface),
        ),
        Text(
          context.tr(metric.labelKey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodySmall(colors.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  IconData _iconFor(String name) {
    return switch (name) {
      'briefcase' => Icons.business_center_outlined,
      'leaf' => Icons.eco_outlined,
      'target' => Icons.track_changes,
      _ => Icons.workspace_premium_outlined,
    };
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/profile.dart';
import 'profile_section_card.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({required this.profile, super.key});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ProfileSectionCard(
      icon: Icons.person_outline,
      titleKey: 'profile.personalInfo',
      children: [
        _InfoRow(icon: Icons.mail_outline, textKey: profile.emailKey),
        const SizedBox(height: AppSpacing.sm),
        _InfoRow(icon: Icons.place_outlined, textKey: profile.locationKey),
        const SizedBox(height: AppSpacing.md),
        Text(
          context.tr(profile.bioKey),
          style: AppTextStyles.bodyMedium(colors.onSurfaceVariant).copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.textKey});

  final IconData icon;
  final String textKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Icon(icon, size: 18, color: colors.onSurfaceVariant),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            context.tr(textKey),
            style: AppTextStyles.bodyMedium(colors.onSurface),
          ),
        ),
      ],
    );
  }
}

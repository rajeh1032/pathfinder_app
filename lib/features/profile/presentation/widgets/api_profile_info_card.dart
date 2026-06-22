import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/user_profile.dart';
import 'profile_section_card.dart';

/// Personal-info card backed by the real profile entity.
class ApiProfileInfoCard extends StatelessWidget {
  const ApiProfileInfoCard({required this.profile, super.key});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bio = profile.bio?.trim();

    final rows = <Widget>[];
    void addRow(IconData icon, String? value) {
      if (value == null || value.trim().isEmpty) return;
      if (rows.isNotEmpty) rows.add(const SizedBox(height: AppSpacing.sm));
      rows.add(_InfoRow(icon: icon, text: value.trim()));
    }

    addRow(Icons.place_outlined, profile.location);
    addRow(Icons.account_balance_outlined, profile.university);
    addRow(Icons.menu_book_outlined, profile.major);

    return ProfileSectionCard(
      icon: Icons.person_outline,
      titleKey: 'profile.personalInfo',
      children: [
        if (rows.isEmpty && (bio == null || bio.isEmpty))
          Text(
            'profile.empty'.tr(),
            style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
          ),
        ...rows,
        if (bio != null && bio.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            bio,
            style: AppTextStyles.bodyMedium(colors.onSurfaceVariant)
                .copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        Icon(icon, size: 18, color: colors.onSurfaceVariant),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium(colors.onSurface),
          ),
        ),
      ],
    );
  }
}

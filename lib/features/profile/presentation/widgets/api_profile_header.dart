import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/user_profile.dart';

/// Header for the API-backed profile: avatar, headline and location.
class ApiProfileHeader extends StatelessWidget {
  const ApiProfileHeader({
    required this.profile,
    required this.onEditPhoto,
    super.key,
  });

  final UserProfile profile;
  final VoidCallback onEditPhoto;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final avatarUrl = profile.avatarUrl;
    final name = (profile.name?.trim().isNotEmpty ?? false)
        ? profile.name!.trim()
        : 'profile.empty'.tr();
    final headline = profile.headline?.trim();
    final education = [profile.university, profile.major]
        .where((v) => v != null && v.trim().isNotEmpty)
        .join(' • ');

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
                border: Border.all(color: colors.surface, width: 4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: CircleAvatar(
                  radius: 56,
                  backgroundColor: colors.primaryContainer,
                  foregroundColor: colors.primary,
                  backgroundImage:
                      (avatarUrl != null && avatarUrl.trim().isNotEmpty)
                          ? NetworkImage(avatarUrl)
                          : null,
                  child: (avatarUrl == null || avatarUrl.trim().isEmpty)
                      ? const Icon(Icons.person_outline, size: 48)
                      : null,
                ),
              ),
            ),
            IconButton.filled(
              onPressed: onEditPhoto,
              style: IconButton.styleFrom(
                minimumSize: const Size(36, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
              icon: const Icon(Icons.edit, size: 18),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          name,
          style: AppTextStyles.headlineLarge(colors.onSurface),
          textAlign: TextAlign.center,
        ),
        if (headline != null && headline.isNotEmpty)
          Text(
            headline,
            style: AppTextStyles.titleSmall(colors.primary),
            textAlign: TextAlign.center,
          ),
        if (education.isNotEmpty)
          Text(
            education,
            style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}

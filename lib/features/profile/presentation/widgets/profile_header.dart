import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/profile.dart';
import 'profile_avatar_image.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.profile,
    required this.onEditPhoto,
    super.key,
  });

  final Profile profile;
  final VoidCallback onEditPhoto;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

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
                child: ProfileAvatarImage(
                  avatarPath: profile.avatarAsset,
                  size: 112,
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
          context.tr(profile.fullNameKey),
          style: AppTextStyles.headlineLarge(colors.onSurface),
          textAlign: TextAlign.center,
        ),
        Text(
          context.tr(profile.headlineKey),
          style: AppTextStyles.titleSmall(colors.primary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

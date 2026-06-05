import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../widgets/profile_preferences_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('profile.title'.tr()),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(
              'profile.preferencesTitle'.tr(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: colors.onSurface,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'profile.preferencesSubtitle'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const ProfilePreferencesSection(),
          ],
        ),
      ),
    );
  }
}

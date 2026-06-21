import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_button.dart';

class RoadmapRequiredActionView extends StatelessWidget {
  const RoadmapRequiredActionView({
    required this.titleKey,
    required this.bodyKey,
    required this.buttonKey,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String titleKey;
  final String bodyKey;
  final String buttonKey;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: colors.primary),
            const SizedBox(height: AppSpacing.lg),
            Text(
              titleKey.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineSmall(colors.onSurface),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              bodyKey.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.xl),
            CustomButton(
              labelKey: buttonKey,
              isLoading: isLoading,
              onPressed: isLoading ? null : onPressed,
            ),
          ],
        ),
      ),
    );
  }
}

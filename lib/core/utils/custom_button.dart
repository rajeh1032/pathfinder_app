import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

enum CustomButtonVariant {
  primary,
  outline,
  destructiveSoft,
  destructiveOutline,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.labelKey,
    required this.onPressed,
    this.icon,
    this.variant = CustomButtonVariant.primary,
    this.isLoading = false,
    this.height = 48,
    super.key,
  });

  final String labelKey;
  final VoidCallback? onPressed;
  final IconData? icon;
  final CustomButtonVariant variant;
  final bool isLoading;
  final double height;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final style = _style(context, enabled);
    final foreground = style.foreground;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Material(
        color: style.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: style.border,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          child: Center(
            child: isLoading
                ? SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: foreground,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: 20, color: foreground),
                        const SizedBox(width: AppSpacing.sm),
                      ],
                      Text(
                        labelKey.tr(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelLarge(foreground),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  _ButtonStyle _style(BuildContext context, bool enabled) {
    final colors = context.colors;
    final disabledForeground = colors.onSurface.withValues(alpha: .38);
    final disabledBackground = colors.onSurface.withValues(alpha: .08);
    final disabledBorder = BorderSide(color: colors.outlineVariant);

    if (!enabled) {
      return _ButtonStyle(
        background: disabledBackground,
        foreground: disabledForeground,
        border: disabledBorder,
      );
    }

    return switch (variant) {
      CustomButtonVariant.primary => _ButtonStyle(
          background: colors.primary,
          foreground: colors.onPrimary,
          border: BorderSide.none,
        ),
      CustomButtonVariant.outline => _ButtonStyle(
          background: colors.surface,
          foreground: colors.primary,
          border: BorderSide(color: colors.outlineVariant),
        ),
      CustomButtonVariant.destructiveSoft => _ButtonStyle(
          background: colors.error.withValues(alpha: .14),
          foreground: colors.error,
          border: BorderSide.none,
        ),
      CustomButtonVariant.destructiveOutline => _ButtonStyle(
          background: colors.surface,
          foreground: colors.error,
          border: BorderSide(color: colors.error.withValues(alpha: .38)),
        ),
    };
  }
}

class _ButtonStyle {
  const _ButtonStyle({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final BorderSide border;
}

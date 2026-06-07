import 'dart:async';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class CustomSnackbar {
  const CustomSnackbar._();

  static OverlayEntry? _activeEntry;

  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(milliseconds: 1800),
  }) {
    _show(
      context: context,
      message: message,
      accentColor: context.colors.primary,
      icon: Icons.check_rounded,
      duration: duration,
    );
  }

  static void showSuccessOverlay({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(milliseconds: 1800),
  }) {
    showSuccess(context: context, message: message, duration: duration);
  }

  static void showSuccessKey({
    required BuildContext context,
    required String messageKey,
  }) {
    showSuccess(context: context, message: messageKey.tr());
  }

  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      context: context,
      message: message,
      accentColor: context.colors.error,
      icon: Icons.close_rounded,
      duration: duration,
    );
  }

  static void showErrorKey({
    required BuildContext context,
    required String messageKey,
  }) {
    showError(context: context, message: messageKey.tr());
  }

  static void showWarning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      context: context,
      message: message,
      accentColor: context.colors.tertiary,
      icon: Icons.priority_high_rounded,
      duration: duration,
    );
  }

  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      context: context,
      message: message,
      accentColor: context.colors.primary,
      icon: Icons.info_outline_rounded,
      duration: duration,
    );
  }

  static void showInfoKey({
    required BuildContext context,
    required String messageKey,
  }) {
    showInfo(context: context, message: messageKey.tr());
  }

  static void _show({
    required BuildContext context,
    required String message,
    required Color accentColor,
    required IconData icon,
    required Duration duration,
  }) {
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: duration),
      );
      return;
    }

    _dismissActiveEntry();

    late final OverlayEntry entry;
    var removed = false;

    void removeEntry() {
      if (removed) return;
      removed = true;
      if (_activeEntry == entry) _activeEntry = null;
      if (entry.mounted) entry.remove();
    }

    entry = OverlayEntry(
      builder: (overlayContext) {
        final mediaQuery = MediaQuery.maybeOf(overlayContext);
        final bottomOffset = math.max(
          (mediaQuery?.viewInsets.bottom ?? 0) +
              (mediaQuery?.padding.bottom ?? 0) +
              AppSpacing.lg,
          AppSpacing.lg,
        );

        return PositionedDirectional(
          start: AppSpacing.lg,
          end: AppSpacing.lg,
          bottom: bottomOffset,
          child: Material(
            color: Colors.transparent,
            child: _SnackbarCard(
              message: message,
              accentColor: accentColor,
              icon: icon,
              onDismiss: removeEntry,
            ),
          ),
        );
      },
    );

    _activeEntry = entry;
    overlay.insert(entry);
    Timer(duration, removeEntry);
  }

  static void _dismissActiveEntry() {
    final entry = _activeEntry;
    _activeEntry = null;
    if (entry?.mounted ?? false) entry!.remove();
  }
}

class _SnackbarCard extends StatelessWidget {
  const _SnackbarCard({
    required this.message,
    required this.accentColor,
    required this.icon,
    required this.onDismiss,
  });

  final String message;
  final Color accentColor;
  final IconData icon;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      container: true,
      liveRegion: true,
      label: message,
      child: GestureDetector(
        onTap: onDismiss,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.inverseSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withValues(alpha: .18),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor,
                  ),
                  child: SizedBox.square(
                    dimension: 34,
                    child: Icon(icon, color: colors.onPrimary, size: 20),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    message,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMedium(colors.onInverseSurface),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

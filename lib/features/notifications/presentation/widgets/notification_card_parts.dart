import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/app_notification.dart';

class NotificationActionRow extends StatelessWidget {
  const NotificationActionRow({
    required this.notification,
    required this.onPrimaryAction,
    required this.onDismiss,
    super.key,
  });

  final AppNotification notification;
  final VoidCallback onPrimaryAction;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final filled = notification.category == NotificationCategory.job;

    return Row(
      children: [
        Expanded(
          child: filled
              ? FilledButton(
                  onPressed: onPrimaryAction,
                  child: Text(notification.actionLabel ?? ''),
                )
              : OutlinedButton(
                  onPressed: onPrimaryAction,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.primary,
                    side: BorderSide(
                      color: colors.primary.withValues(alpha: .2),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                  ),
                  child: Text(notification.actionLabel ?? ''),
                ),
        ),
        if (notification.category == NotificationCategory.job) ...[
          const SizedBox(width: AppSpacing.sm),
          IconButton.outlined(
            onPressed: onDismiss,
            icon: const Icon(Icons.close, size: 18),
          ),
        ],
      ],
    );
  }
}

class NotificationIconBubble extends StatelessWidget {
  const NotificationIconBubble({required this.category, super.key});

  final NotificationCategory category;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final gradient = category == NotificationCategory.insight;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient ? AppGradients.aiTertiary : null,
        color: gradient ? null : _backgroundColor(colors),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Icon(
          _iconFor(category),
          size: 22,
          color: gradient ? colors.onPrimary : _foregroundColor(colors),
        ),
      ),
    );
  }

  Color _backgroundColor(ColorScheme colors) {
    return switch (category) {
      NotificationCategory.interview => colors.tertiaryContainer,
      NotificationCategory.document => colors.surfaceContainerHighest,
      _ => colors.primaryContainer,
    };
  }

  Color _foregroundColor(ColorScheme colors) {
    return switch (category) {
      NotificationCategory.interview => colors.tertiary,
      NotificationCategory.document => colors.onSurfaceVariant,
      _ => colors.primary,
    };
  }

  IconData _iconFor(NotificationCategory category) {
    return switch (category) {
      NotificationCategory.job => Icons.work_outline,
      NotificationCategory.interview => Icons.videocam_outlined,
      NotificationCategory.insight => Icons.psychology_outlined,
      NotificationCategory.learning => Icons.menu_book_outlined,
      NotificationCategory.document => Icons.description_outlined,
      NotificationCategory.other => Icons.notifications_outlined,
    };
  }
}

class NotificationScoreBadge extends StatelessWidget {
  const NotificationScoreBadge(this.score, {super.key});

  final String score;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.tertiary.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: colors.tertiary.withValues(alpha: .24)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          score,
          style: AppTextStyles.labelSmall(colors.tertiary),
        ),
      ),
    );
  }
}

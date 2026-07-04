import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/app_notification.dart';
import 'notification_card_parts.dart';
import 'notification_formatting.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: notification.isRead
            ? Border.all(color: colors.outlineVariant)
            : BorderDirectional(
                start: BorderSide(color: colors.primary, width: 3),
              ),
        boxShadow: AppShadows.card,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          notification.isRead ? AppSpacing.md : AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationIconBubble(category: notification.category),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _NotificationContent(
                notification: notification,
                onPrimaryAction: onPrimaryAction,
                onDismiss: onDismiss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationContent extends StatelessWidget {
  const _NotificationContent({
    required this.notification,
    required this.onPrimaryAction,
    required this.onDismiss,
  });

  final AppNotification notification;
  final VoidCallback onPrimaryAction;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final body = notification.body ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NotificationMetaRow(notification: notification),
        const SizedBox(height: AppSpacing.xs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: notification.category == NotificationCategory.insight
                    ? AppTextStyles.bodyMedium(colors.onSurface)
                    : AppTextStyles.titleSmall(colors.onSurface),
              ),
            ),
            if (notification.score != null)
              NotificationScoreBadge(notification.score!),
          ],
        ),
        if (body.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(body, style: AppTextStyles.bodySmall(colors.onSurfaceVariant)),
        ],
        if (notification.progress != null) ...[
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: notification.progress,
              color: colors.primary,
              backgroundColor: colors.primaryContainer,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            NotificationFormatting.progressLabel(notification.progress!),
            style: AppTextStyles.labelSmall(colors.onSurfaceVariant),
          ),
        ],
        if (notification.hasAction) ...[
          const SizedBox(height: AppSpacing.md),
          NotificationActionRow(
            notification: notification,
            onPrimaryAction: onPrimaryAction,
            onDismiss: onDismiss,
          ),
        ],
      ],
    );
  }
}

class _NotificationMetaRow extends StatelessWidget {
  const _NotificationMetaRow({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            NotificationFormatting.categoryLabelKey(notification.category)
                .tr()
                .toUpperCase(),
            style: AppTextStyles.labelSmall(_accentColor(context)),
          ),
        ),
        Text(
          NotificationFormatting.relativeTime(notification.createdAt),
          style: AppTextStyles.labelSmall(colors.onSurfaceVariant),
        ),
        if (!notification.isRead) ...[
          const SizedBox(width: AppSpacing.xs),
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: const SizedBox(width: 8, height: 8),
          ),
        ],
      ],
    );
  }

  Color _accentColor(BuildContext context) {
    final colors = context.colors;
    return switch (notification.category) {
      NotificationCategory.job => colors.primary,
      NotificationCategory.interview => colors.secondary,
      NotificationCategory.insight => colors.tertiary,
      NotificationCategory.learning => colors.tertiary,
      NotificationCategory.document => colors.primary,
      NotificationCategory.other => colors.onSurfaceVariant,
    };
  }
}

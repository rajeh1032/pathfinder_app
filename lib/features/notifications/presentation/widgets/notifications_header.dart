import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import 'notification_filter_tabs.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({required this.unreadCount, super.key});

  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'notifications.title'.tr(),
                    style: AppTextStyles.headlineMedium(colors.onSurface),
                  ),
                  Text(
                    'notifications.subtitle'.tr(),
                    style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            onPressed: unreadCount == 0 ? null : () => _markAllAsRead(context),
            icon: const Icon(Icons.done_all, size: 16),
            label: Text('notifications.markAllRead'.tr()),
          ),
        ),
      ],
    );
  }

  Future<void> _markAllAsRead(BuildContext context) async {
    await context.read<NotificationsCubit>().markAllAsRead();
    if (context.mounted) {
      showNotificationsMessage(context, 'notifications.readSuccess');
    }
  }
}

class NotificationsSectionHeader extends StatelessWidget {
  const NotificationsSectionHeader({required this.titleKey, super.key});

  final String titleKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, AppSpacing.md, 4, AppSpacing.sm),
      child: Text(
        titleKey.tr(),
        style: AppTextStyles.titleSmall(context.colors.onSurfaceVariant),
      ),
    );
  }
}

class NotificationsEmptyContent extends StatelessWidget {
  const NotificationsEmptyContent({required this.selectedFilter, super.key});

  final NotificationFilter selectedFilter;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const NotificationsHeader(unreadCount: 0),
        const SizedBox(height: AppSpacing.md),
        NotificationFilterTabs(
          selectedFilter: selectedFilter,
          onSelected: context.read<NotificationsCubit>().selectFilter,
        ),
        const SizedBox(height: AppSpacing.xl),
        AppErrorView(
          message: 'notifications.empty'.tr(),
          onRetry: context.read<NotificationsCubit>().loadNotifications,
        ),
      ],
    );
  }
}

void showNotificationsMessage(BuildContext context, String messageKey) {
  CustomSnackbar.showInfoKey(context: context, messageKey: messageKey);
}

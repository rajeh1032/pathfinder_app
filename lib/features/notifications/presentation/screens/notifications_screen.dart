import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../data/repositories/demo_notifications_repository.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/use_cases/dismiss_notification_use_case.dart';
import '../../domain/use_cases/get_notifications_use_case.dart';
import '../../domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import '../../domain/use_cases/mark_notification_as_read_use_case.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_filter_tabs.dart';
import '../widgets/notifications_header.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final repository = DemoNotificationsRepository();
        return NotificationsCubit(
          getNotificationsUseCase: GetNotificationsUseCase(repository),
          markAsReadUseCase: MarkNotificationAsReadUseCase(repository),
          markAllAsReadUseCase: MarkAllNotificationsAsReadUseCase(repository),
          dismissNotificationUseCase: DismissNotificationUseCase(repository),
        )..loadNotifications();
      },
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text('notifications.title'.tr()),
      ),
      body: SafeArea(
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsSuccess) {
              return _NotificationsContent(state: state);
            }

            if (state is NotificationsEmpty) {
              return NotificationsEmptyContent(
                selectedFilter: state.selectedFilter,
              );
            }

            if (state is NotificationsError) {
              return AppErrorView(
                message: state.messageKey.tr(),
                onRetry: context.read<NotificationsCubit>().loadNotifications,
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _NotificationsContent extends StatelessWidget {
  const _NotificationsContent({required this.state});

  final NotificationsSuccess state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      children: [
        NotificationsHeader(unreadCount: state.unreadCount),
        const SizedBox(height: AppSpacing.md),
        NotificationFilterTabs(
          selectedFilter: state.selectedFilter,
          onSelected: context.read<NotificationsCubit>().selectFilter,
        ),
        const SizedBox(height: AppSpacing.md),
        ..._notificationWidgets(context, state.notifications),
      ],
    );
  }

  List<Widget> _notificationWidgets(
    BuildContext context,
    List<AppNotification> notifications,
  ) {
    final widgets = <Widget>[];
    String? currentSection;

    for (final notification in notifications) {
      if (notification.sectionKey != null &&
          notification.sectionKey != currentSection) {
        currentSection = notification.sectionKey;
        widgets.add(NotificationsSectionHeader(titleKey: currentSection!));
      }

      widgets
        ..add(
          Dismissible(
            key: ValueKey(notification.id),
            direction: DismissDirection.horizontal,
            background: const _NotificationDismissBackground(),
            secondaryBackground: const _NotificationDismissBackground(
              alignment: AlignmentDirectional.centerEnd,
            ),
            onDismissed: (_) => _dismissNotification(context, notification.id),
            child: NotificationCard(
              notification: notification,
              onPrimaryAction: () => _openNotification(context, notification),
              onDismiss: () => _dismissNotification(context, notification.id),
            ),
          ),
        )
        ..add(const SizedBox(height: AppSpacing.sm));
    }

    return widgets;
  }

  Future<void> _openNotification(
    BuildContext context,
    AppNotification notification,
  ) async {
    await context.read<NotificationsCubit>().markAsRead(notification.id);
    if (context.mounted) {
      showNotificationsMessage(context, 'notifications.actionReady');
    }
  }

  Future<void> _dismissNotification(BuildContext context, String id) async {
    await context.read<NotificationsCubit>().dismissNotification(id);
    if (context.mounted) {
      showNotificationsMessage(context, 'notifications.dismissed');
    }
  }
}

class _NotificationDismissBackground extends StatelessWidget {
  const _NotificationDismissBackground({
    this.alignment = AlignmentDirectional.centerStart,
  });

  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.error.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Icon(Icons.delete_outline, color: colors.error),
        ),
      ),
    );
  }
}

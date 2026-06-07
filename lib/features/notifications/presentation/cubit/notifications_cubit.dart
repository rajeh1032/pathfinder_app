import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/app_notification.dart';
import '../../domain/use_cases/dismiss_notification_use_case.dart';
import '../../domain/use_cases/get_notifications_use_case.dart';
import '../../domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import '../../domain/use_cases/mark_notification_as_read_use_case.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({
    required GetNotificationsUseCase getNotificationsUseCase,
    required MarkNotificationAsReadUseCase markAsReadUseCase,
    required MarkAllNotificationsAsReadUseCase markAllAsReadUseCase,
    required DismissNotificationUseCase dismissNotificationUseCase,
  })  : _getNotificationsUseCase = getNotificationsUseCase,
        _markAsReadUseCase = markAsReadUseCase,
        _markAllAsReadUseCase = markAllAsReadUseCase,
        _dismissNotificationUseCase = dismissNotificationUseCase,
        super(const NotificationsInitial());

  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkNotificationAsReadUseCase _markAsReadUseCase;
  final MarkAllNotificationsAsReadUseCase _markAllAsReadUseCase;
  final DismissNotificationUseCase _dismissNotificationUseCase;

  List<AppNotification> _allNotifications = const [];
  NotificationFilter _selectedFilter = NotificationFilter.all;

  Future<void> loadNotifications() async {
    emit(const NotificationsLoading());
    _selectedFilter = NotificationFilter.all;
    final result = await _getNotificationsUseCase();
    result.fold(
      (failure) => emit(NotificationsError(messageKey: failure.message)),
      (notifications) {
        _allNotifications = notifications;
        _emitFiltered();
      },
    );
  }

  void selectFilter(NotificationFilter filter) {
    _selectedFilter = filter;
    _emitFiltered();
  }

  Future<void> markAsRead(String id) async {
    final result = await _markAsReadUseCase(id);
    result.fold(
      (failure) => emit(NotificationsError(messageKey: failure.message)),
      (notifications) {
        _allNotifications = notifications;
        _emitFiltered();
      },
    );
  }

  Future<void> markAllAsRead() async {
    final result = await _markAllAsReadUseCase();
    result.fold(
      (failure) => emit(NotificationsError(messageKey: failure.message)),
      (notifications) {
        _allNotifications = notifications;
        _emitFiltered();
      },
    );
  }

  Future<void> dismissNotification(String id) async {
    final result = await _dismissNotificationUseCase(id);
    result.fold(
      (failure) => emit(NotificationsError(messageKey: failure.message)),
      (notifications) {
        _allNotifications = notifications;
        _emitFiltered();
      },
    );
  }

  void _emitFiltered() {
    final filtered = _filteredNotifications();
    if (filtered.isEmpty) {
      emit(NotificationsEmpty(selectedFilter: _selectedFilter));
      return;
    }

    emit(
      NotificationsSuccess(
        notifications: filtered,
        unreadCount: _allNotifications
            .where((notification) => !notification.isRead)
            .length,
        selectedFilter: _selectedFilter,
      ),
    );
  }

  List<AppNotification> _filteredNotifications() {
    return _allNotifications.where((notification) {
      return switch (_selectedFilter) {
        NotificationFilter.all => true,
        NotificationFilter.jobs =>
          notification.category == NotificationCategory.job,
        NotificationFilter.learning =>
          notification.category == NotificationCategory.learning,
        NotificationFilter.roadmaps =>
          notification.category == NotificationCategory.learning,
        NotificationFilter.aiMentor =>
          notification.category == NotificationCategory.interview ||
              notification.category == NotificationCategory.insight,
      };
    }).toList();
  }
}

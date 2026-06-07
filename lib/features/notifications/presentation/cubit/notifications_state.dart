import 'package:equatable/equatable.dart';

import '../../domain/entities/app_notification.dart';

enum NotificationFilter { all, jobs, learning, roadmaps, aiMentor }

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsSuccess extends NotificationsState {
  const NotificationsSuccess({
    required this.notifications,
    required this.unreadCount,
    this.selectedFilter = NotificationFilter.all,
  });

  final List<AppNotification> notifications;
  final int unreadCount;
  final NotificationFilter selectedFilter;

  @override
  List<Object?> get props => [notifications, unreadCount, selectedFilter];
}

class NotificationsEmpty extends NotificationsState {
  const NotificationsEmpty({this.selectedFilter = NotificationFilter.all});

  final NotificationFilter selectedFilter;

  @override
  List<Object?> get props => [selectedFilter];
}

class NotificationsError extends NotificationsState {
  const NotificationsError({this.messageKey = 'common.error'});

  final String messageKey;

  @override
  List<Object?> get props => [messageKey];
}

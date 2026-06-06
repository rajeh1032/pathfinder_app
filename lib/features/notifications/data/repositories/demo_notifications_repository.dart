import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notifications_repository.dart';

class DemoNotificationsRepository implements NotificationsRepository {
  DemoNotificationsRepository();

  List<AppNotification> _notifications = List.of(demoNotifications);

  @override
  Future<Either<Failure, List<AppNotification>>> getNotifications() async {
    return Right(List.unmodifiable(_notifications));
  }

  @override
  Future<Either<Failure, List<AppNotification>>> markAsRead(String id) async {
    _notifications = _notifications
        .map((item) => item.id == id ? item.copyWith(isRead: true) : item)
        .toList();
    return Right(List.unmodifiable(_notifications));
  }

  @override
  Future<Either<Failure, List<AppNotification>>> markAllAsRead() async {
    _notifications =
        _notifications.map((item) => item.copyWith(isRead: true)).toList();
    return Right(List.unmodifiable(_notifications));
  }

  @override
  Future<Either<Failure, List<AppNotification>>> dismissNotification(
    String id,
  ) async {
    _notifications = _notifications.where((item) => item.id != id).toList();
    return Right(List.unmodifiable(_notifications));
  }
}

const demoNotifications = [
  AppNotification(
    id: 'stripe-match',
    category: NotificationCategory.job,
    labelKey: 'notifications.labelHighMatch',
    titleKey: 'notifications.jobMatchTitle',
    bodyKey: 'notifications.jobMatchBody',
    timeKey: 'notifications.timeTwoMinutes',
    actionLabelKey: 'notifications.viewJob',
    isRead: false,
  ),
  AppNotification(
    id: 'mock-interview',
    category: NotificationCategory.interview,
    labelKey: 'notifications.labelUpcomingEvent',
    titleKey: 'notifications.interviewTitle',
    bodyKey: 'notifications.interviewBody',
    timeKey: 'notifications.timeNow',
    actionLabelKey: 'notifications.startPrep',
    isRead: false,
  ),
  AppNotification(
    id: 'salary-insight',
    category: NotificationCategory.insight,
    labelKey: 'notifications.labelSmartInsight',
    titleKey: 'notifications.insightTitle',
    bodyKey: 'notifications.emptyBody',
    timeKey: 'notifications.timeTwoHours',
    actionLabelKey: 'notifications.analyzeSkillPath',
    isRead: true,
  ),
  AppNotification(
    id: 'react-progress',
    category: NotificationCategory.learning,
    labelKey: 'notifications.labelCourseProgress',
    titleKey: 'notifications.learningTitle',
    bodyKey: 'notifications.emptyBody',
    timeKey: 'notifications.timeYesterday',
    actionLabelKey: 'notifications.continueLearning',
    progress: .85,
    progressLabelKey: 'notifications.progress85',
    isRead: true,
  ),
  AppNotification(
    id: 'cv-ready',
    category: NotificationCategory.document,
    labelKey: 'notifications.labelDocumentReview',
    titleKey: 'notifications.cvTitle',
    bodyKey: 'notifications.cvBody',
    timeKey: 'notifications.timeMonday',
    actionLabelKey: 'notifications.viewAnalysis',
    scoreKey: 'notifications.cvScore',
    sectionKey: 'notifications.earlierThisWeek',
    isRead: true,
  ),
];

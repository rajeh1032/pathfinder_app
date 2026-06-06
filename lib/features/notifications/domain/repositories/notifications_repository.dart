import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/app_notification.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<AppNotification>>> getNotifications();

  Future<Either<Failure, List<AppNotification>>> markAsRead(String id);

  Future<Either<Failure, List<AppNotification>>> markAllAsRead();

  Future<Either<Failure, List<AppNotification>>> dismissNotification(String id);
}

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/app_notification.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<AppNotification>>> getNotifications();

  Future<Either<Failure, AppNotification>> markAsRead(String id);

  Future<Either<Failure, Unit>> markAllAsRead();

  Future<Either<Failure, Unit>> dismissNotification(String id);

  Future<Either<Failure, Unit>> registerDevice({
    required String token,
    required String platform,
  });

  Future<Either<Failure, Unit>> unregisterDevice(String token);
}

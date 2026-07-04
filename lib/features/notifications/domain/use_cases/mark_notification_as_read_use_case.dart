import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/app_notification.dart';
import '../repositories/notifications_repository.dart';

class MarkNotificationAsReadUseCase {
  const MarkNotificationAsReadUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, AppNotification>> call(String id) {
    return _repository.markAsRead(id);
  }
}

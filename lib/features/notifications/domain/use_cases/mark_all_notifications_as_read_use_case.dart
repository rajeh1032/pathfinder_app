import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class MarkAllNotificationsAsReadUseCase {
  const MarkAllNotificationsAsReadUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, Unit>> call() {
    return _repository.markAllAsRead();
  }
}

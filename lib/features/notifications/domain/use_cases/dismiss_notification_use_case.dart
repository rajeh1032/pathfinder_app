import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class DismissNotificationUseCase {
  const DismissNotificationUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, Unit>> call(String id) {
    return _repository.dismissNotification(id);
  }
}

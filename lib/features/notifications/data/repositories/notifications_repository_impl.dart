import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../data_sources/remote/notifications_remote_data_source.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(this._remoteDataSource, this._networkInfo);

  final NotificationsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<AppNotification>>> getNotifications() {
    return _guard(() async {
      final models = await _remoteDataSource.getNotifications();
      return models.map((model) => model.toEntity()).toList(growable: false);
    });
  }

  @override
  Future<Either<Failure, AppNotification>> markAsRead(String id) {
    return _guard(() async {
      final model = await _remoteDataSource.markAsRead(id);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> markAllAsRead() {
    return _guard(() async {
      await _remoteDataSource.markAllAsRead();
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> dismissNotification(String id) {
    return _guard(() async {
      await _remoteDataSource.dismissNotification(id);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> registerDevice({
    required String token,
    required String platform,
  }) {
    return _guard(() async {
      await _remoteDataSource.registerDevice(token: token, platform: platform);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> unregisterDevice(String token) {
    return _guard(() async {
      await _remoteDataSource.unregisterDevice(token);
      return unit;
    });
  }

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() request) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      return Right(await request());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinder_app/features/auth/data/models/register_model.dart';
import 'package:pathfinder_app/features/auth/domain/entities/register_data.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/local/auth_local_data_source.dart';
import '../data_sources/remote/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, AuthSession>> login({
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      final session = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      await _localDataSource.cacheSession(session);
      return Right(session.toEntity());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }

  @override
  Future<Either<Failure, AuthSession>> register({
    required RegisterRegistrationData registrationData,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      final model = RegisterRegistrationModel(
        email: registrationData.email,
        password: registrationData.password,
        confirmPassword: registrationData.confirmPassword,
        name: registrationData.name,
        university: registrationData.university,
        major: registrationData.major,
        location: registrationData.location,
        educationLevel: registrationData.educationLevel,
        experienceYear: registrationData.experienceYear,
        currentStatus: registrationData.currentStatus,
        targetCareer: registrationData.targetCareer,
      );

      // 3. استدعاء الـ API وحفظ الـ Session
      final session = await _remoteDataSource.register(registrationModel: model);
      
      // كاش للـ session محلياً لعمل auto-login مباشرة للمستخدم
      await _localDataSource.cacheSession(session);
      
      // 4. إرجاع الـ Entity للـ UI / Cubit تماشياً مع قاعدة Layering
      return Right(session.toEntity());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }
}
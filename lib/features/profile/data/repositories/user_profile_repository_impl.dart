import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/education_entry.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/work_experience.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../data_sources/remote/profile_remote_data_source.dart';

@LazySingleton(as: UserProfileRepository)
class UserProfileRepositoryImpl implements UserProfileRepository {
  const UserProfileRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  final ProfileRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  /// Runs [action] behind a connectivity check, mapping all failures to
  /// the project's [Failure] types.
  Future<Either<Failure, T>> _guard<T>(Future<T> Function() action) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }
    try {
      return Right(await action());
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } on FormatException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }

  // ── Profile ───────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, UserProfile>> getMyProfile() =>
      _guard(() async => (await _remoteDataSource.getMyProfile()).toEntity());

  @override
  Future<Either<Failure, UserProfile>> updateMyProfile(
    Map<String, dynamic> changes,
  ) =>
      _guard(() async =>
          (await _remoteDataSource.updateMyProfile(changes)).toEntity());

  // ── Experiences ─────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, List<WorkExperience>>> getExperiences() =>
      _guard(() async => (await _remoteDataSource.getExperiences())
          .map((m) => m.toEntity())
          .toList());

  @override
  Future<Either<Failure, WorkExperience>> createExperience(
    WorkExperienceInput input,
  ) =>
      _guard(() async =>
          (await _remoteDataSource.createExperience(input)).toEntity());

  @override
  Future<Either<Failure, WorkExperience>> updateExperience(
    String id,
    WorkExperienceInput input,
  ) =>
      _guard(() async =>
          (await _remoteDataSource.updateExperience(id, input)).toEntity());

  @override
  Future<Either<Failure, String>> deleteExperience(String id) =>
      _guard(() => _remoteDataSource.deleteExperience(id));

  // ── Education ─────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, List<EducationEntry>>> getEducation() =>
      _guard(() async => (await _remoteDataSource.getEducation())
          .map((m) => m.toEntity())
          .toList());

  @override
  Future<Either<Failure, EducationEntry>> createEducation(
    EducationInput input,
  ) =>
      _guard(() async =>
          (await _remoteDataSource.createEducation(input)).toEntity());

  @override
  Future<Either<Failure, EducationEntry>> updateEducation(
    String id,
    EducationInput input,
  ) =>
      _guard(() async =>
          (await _remoteDataSource.updateEducation(id, input)).toEntity());

  @override
  Future<Either<Failure, bool>> deleteEducation(String id) =>
      _guard(() => _remoteDataSource.deleteEducation(id));
}

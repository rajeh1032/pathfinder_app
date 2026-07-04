import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/roadmap.dart';
import '../../domain/entities/roadmap_status.dart';
import '../../domain/repositories/roadmaps_repository.dart';
import '../data_sources/remote/roadmaps_remote_data_source.dart';

@LazySingleton(as: RoadmapsRepository)
class RoadmapsRepositoryImpl implements RoadmapsRepository {
  const RoadmapsRepositoryImpl(this._remoteDataSource, this._networkInfo);

  final RoadmapsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, RoadmapStatus>> getMyRoadmap() =>
      _execute(() async => (await _remoteDataSource.getMyRoadmap()).toEntity());

  @override
  Future<Either<Failure, GenerateRoadmapResult>> generateRoadmap({
    bool forceRegenerate = false,
  }) =>
      _execute(
        () async => (await _remoteDataSource.generateRoadmap(
          forceRegenerate: forceRegenerate,
        ))
            .toEntity(),
      );

  @override
  Future<Either<Failure, Roadmap>> getRoadmapDetails(String roadmapId) =>
      _execute(
        () async =>
            (await _remoteDataSource.getRoadmapDetails(roadmapId)).toEntity(),
      );

  @override
  Future<Either<Failure, Roadmap>> updateStepProgress({
    required String roadmapId,
    required String stepId,
    required int progress,
    bool? isCompleted,
  }) =>
      _execute(
        () async => (await _remoteDataSource.updateStepProgress(
          roadmapId: roadmapId,
          stepId: stepId,
          progress: progress,
          isCompleted: isCompleted,
        ))
            .toEntity(),
      );

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }
    try {
      return Right(await action());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException {
      return const Left(ServerFailure(ErrorMessages.server));
    }
  }
}

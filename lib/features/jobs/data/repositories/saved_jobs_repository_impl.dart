import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/saved_job.dart';
import '../../domain/repositories/saved_jobs_repository.dart';
import '../data_sources/remote/saved_jobs_remote_data_source.dart';

@LazySingleton(as: SavedJobsRepository)
class SavedJobsRepositoryImpl implements SavedJobsRepository {
  const SavedJobsRepositoryImpl(this._remoteDataSource, this._networkInfo);

  final SavedJobsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<SavedJob>>> getSavedJobs() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }
    try {
      final models = await _remoteDataSource.getSavedJobs();
      return Right(models.map((m) => m.toEntity()).toList());
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } on FormatException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }
}

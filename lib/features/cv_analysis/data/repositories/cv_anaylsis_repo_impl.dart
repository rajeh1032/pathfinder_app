import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/cv_anaysis_entity.dart';
import '../../domain/repositories/cv_anaylsis_repo.dart';
import '../data_sources/remote/cv_anaylsis_remote_data_source.dart';

@LazySingleton(as: CvAnalysisRepository)
class CvAnalysisRepositoryImpl implements CvAnalysisRepository {
  const CvAnalysisRepositoryImpl(this._remoteDataSource, this._networkInfo);

  final CvAnalysisRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, CvStatusEntity>> getCvStatus() =>
      _request(() async => (await _remoteDataSource.getCvStatus()).toEntity());

  @override
  Future<Either<Failure, CvWithAnalysisEntity>> uploadAndAnalyze(
    String filePath,
  ) =>
      _request(
        () async =>
            (await _remoteDataSource.uploadAndAnalyze(filePath)).toEntity(),
      );

  @override
  Future<Either<Failure, CvWithAnalysisEntity>> getLatestAnalysis() => _request(
        () async => (await _remoteDataSource.getLatestAnalysis()).toEntity(),
      );

  Future<Either<Failure, T>> _request<T>(Future<T> Function() request) async {
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

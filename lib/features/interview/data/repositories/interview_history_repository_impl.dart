import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/interview_history.dart';
import '../../domain/repositories/interview_history_repository.dart';
import '../data_sources/remote/interview_history_remote_data_source.dart';

@LazySingleton(as: InterviewHistoryRepository)
class InterviewHistoryRepositoryImpl implements InterviewHistoryRepository {
  const InterviewHistoryRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  final InterviewHistoryRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, InterviewHistory>> getHistory({
    String? query,
    String? interviewType,
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      final model = await _remoteDataSource.getHistory(
        query: query,
        interviewType: interviewType,
        status: status,
        page: page,
        limit: limit,
      );
      return Right(model.toEntity());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }
}

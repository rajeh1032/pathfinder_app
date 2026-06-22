import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/interview_career_path.dart';
import '../../domain/entities/interview_session.dart';
import '../../domain/repositories/interview_repository.dart';
import '../data_sources/remote/interview_remote_data_source.dart';

@LazySingleton(as: InterviewRepository)
class InterviewRepositoryImpl implements InterviewRepository {
  const InterviewRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  final InterviewRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<InterviewCareerPath>>> getCareerPaths() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      final models = await _remoteDataSource.getCareerPaths();
      return Right(models.map((model) => model.toEntity()).toList());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }

  @override
  Future<Either<Failure, InterviewSession>> createSession({
    required String careerPathId,
    required String interviewType,
    required int totalQuestions,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      final model = await _remoteDataSource.createSession(
        careerPathId: careerPathId,
        interviewType: interviewType,
        totalQuestions: totalQuestions,
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

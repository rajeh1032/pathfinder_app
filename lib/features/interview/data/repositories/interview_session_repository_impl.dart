import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/interview_session_questions.dart';
import '../../domain/entities/interview_result.dart';
import '../../domain/repositories/interview_session_repository.dart';
import '../data_sources/remote/interview_session_remote_data_source.dart';

@LazySingleton(as: InterviewSessionRepository)
class InterviewSessionRepositoryImpl implements InterviewSessionRepository {
  const InterviewSessionRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  final InterviewSessionRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, InterviewSessionQuestions>> getSessionQuestions(
    String sessionId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      final model = await _remoteDataSource.getSessionQuestions(sessionId);
      return Right(model.toEntity());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }

  @override
  Future<Either<Failure, InterviewResult>> getSessionResult(
    String sessionId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      final model = await _remoteDataSource.getSessionResult(sessionId);
      return Right(model.toEntity());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveAnswer({
    required String sessionId,
    required String questionId,
    required int selectedOptionIndex,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      await _remoteDataSource.saveAnswer(
        sessionId: sessionId,
        questionId: questionId,
        selectedOptionIndex: selectedOptionIndex,
      );
      return const Right(unit);
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }

  @override
  Future<Either<Failure, Unit>> skipQuestion({
    required String sessionId,
    required String questionId,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      await _remoteDataSource.skipQuestion(
        sessionId: sessionId,
        questionId: questionId,
      );
      return const Right(unit);
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelSession(String sessionId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      await _remoteDataSource.cancelSession(sessionId);
      return const Right(unit);
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }

  @override
  Future<Either<Failure, Unit>> finishSession(String sessionId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      await _remoteDataSource.finishSession(sessionId);
      return const Right(unit);
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }
}

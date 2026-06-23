import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/cover_letter.dart';
import '../../domain/repositories/cover_letters_repository.dart';
import '../data_sources/remote/cover_letters_remote_data_source.dart';

class CoverLettersRepositoryImpl implements CoverLettersRepository {
  const CoverLettersRepositoryImpl(this._remoteDataSource, this._networkInfo);

  final CoverLettersRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, CoverLetter>> generateCoverLetter({
    required String jobId,
    String tone = 'professional',
    List<String> keywords = const [],
    String companyInterest = '',
    String achievement = '',
    String language = 'en',
  }) {
    return _guard(() => _remoteDataSource.generateCoverLetter(
          jobId: jobId,
          tone: tone,
          keywords: keywords,
          companyInterest: companyInterest,
          achievement: achievement,
          language: language,
        ));
  }

  @override
  Future<Either<Failure, List<CoverLetter>>> getCoverLetters() {
    return _guard(_remoteDataSource.getCoverLetters);
  }

  @override
  Future<Either<Failure, CoverLetter>> getCoverLetter(String id) {
    return _guard(() => _remoteDataSource.getCoverLetter(id));
  }

  @override
  Future<Either<Failure, CoverLetter>> updateCoverLetter({
    required String id,
    required String content,
  }) {
    return _guard(
      () => _remoteDataSource.updateCoverLetter(id: id, content: content),
    );
  }

  @override
  Future<Either<Failure, CoverLetter>> exportCoverLetter(String id) {
    return _guard(() => _remoteDataSource.exportCoverLetter(id));
  }

  @override
  Future<Either<Failure, void>> deleteCoverLetter(String id) {
    return _guard(() => _remoteDataSource.deleteCoverLetter(id));
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

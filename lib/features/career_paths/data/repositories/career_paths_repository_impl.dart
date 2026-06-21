import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/career_path.dart';
import '../../domain/repositories/career_paths_repository.dart';
import '../data_sources/remote/career_paths_remote_data_source.dart';

@LazySingleton(as: CareerPathsRepository)
class CareerPathsRepositoryImpl implements CareerPathsRepository {
  const CareerPathsRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  final CareerPathsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<CareerPath>>> getCareerPaths() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }

    try {
      final models = await _remoteDataSource.getCareerPaths();
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

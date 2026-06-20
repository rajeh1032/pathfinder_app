import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/career_path.dart';
import '../repositories/career_paths_repository.dart';

@lazySingleton
class GetCareerPathsUseCase {
  const GetCareerPathsUseCase(this._repository);

  final CareerPathsRepository _repository;

  Future<Either<Failure, List<CareerPath>>> call() {
    return _repository.getCareerPaths();
  }
}

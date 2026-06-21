import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/career_path.dart';

abstract class CareerPathsRepository {
  Future<Either<Failure, List<CareerPath>>> getCareerPaths();
}

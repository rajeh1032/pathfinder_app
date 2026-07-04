import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/home_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeSummaryEntity>> getHomeSummary();
}

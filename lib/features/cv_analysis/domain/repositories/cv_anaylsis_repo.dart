import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cv_anaysis_entity.dart';

abstract class CvAnalysisRepository {
  Future<Either<Failure, CvStatusEntity>> getCvStatus();
  Future<Either<Failure, CvWithAnalysisEntity>> uploadAndAnalyze(
    String filePath,
  );
  Future<Either<Failure, CvWithAnalysisEntity>> getLatestAnalysis();
  Future<Either<Failure, CvHistoryResultEntity>> getHistory();
  Future<Either<Failure, CvFileUrlEntity>> getFileUrl(String cvId);
}

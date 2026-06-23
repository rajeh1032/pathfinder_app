import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cover_letter.dart';

abstract class CoverLettersRepository {
  Future<Either<Failure, CoverLetter>> generateCoverLetter({
    required String jobId,
    String tone = 'professional',
    List<String> keywords = const [],
    String companyInterest = '',
    String achievement = '',
    String language = 'en',
  });

  Future<Either<Failure, List<CoverLetter>>> getCoverLetters();

  Future<Either<Failure, CoverLetter>> getCoverLetter(String id);

  Future<Either<Failure, CoverLetter>> updateCoverLetter({
    required String id,
    required String content,
  });

  Future<Either<Failure, CoverLetter>> exportCoverLetter(String id);

  Future<Either<Failure, void>> deleteCoverLetter(String id);
}

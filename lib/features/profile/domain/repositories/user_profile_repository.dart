import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/education_entry.dart';
import '../entities/user_profile.dart';
import '../entities/work_experience.dart';

/// API-backed profile repository for the PathFinder Profiles module.
abstract class UserProfileRepository {
  Future<Either<Failure, UserProfile>> getMyProfile();
  Future<Either<Failure, UserProfile>> updateMyProfile(
    Map<String, dynamic> changes,
  );

  Future<Either<Failure, List<WorkExperience>>> getExperiences();
  Future<Either<Failure, WorkExperience>> createExperience(
    WorkExperienceInput input,
  );
  Future<Either<Failure, WorkExperience>> updateExperience(
    String id,
    WorkExperienceInput input,
  );
  Future<Either<Failure, String>> deleteExperience(String id);

  Future<Either<Failure, List<EducationEntry>>> getEducation();
  Future<Either<Failure, EducationEntry>> createEducation(EducationInput input);
  Future<Either<Failure, EducationEntry>> updateEducation(
    String id,
    EducationInput input,
  );
  Future<Either<Failure, bool>> deleteEducation(String id);
}

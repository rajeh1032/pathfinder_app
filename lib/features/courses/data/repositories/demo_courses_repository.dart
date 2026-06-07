import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/courses_repository.dart';

class DemoCoursesRepository implements CoursesRepository {
  const DemoCoursesRepository();

  @override
  Future<Either<Failure, List<Course>>> getCourses() async {
    return const Right(demoCourses);
  }

  @override
  Future<Either<Failure, Course>> getCourseDetails(String id) async {
    Course? course;
    for (final item in demoCourses) {
      if (item.id == id) {
        course = item;
        break;
      }
    }

    if (course == null) {
      return const Left(ValidationFailure('courses.invalidId'));
    }

    return Right(course.copyWith(imageAsset: AppAssets.courseDetailHero));
  }
}

const demoCourses = [
  Course(
    id: 'product-management',
    titleKey: 'courses.productManagement',
    providerKey: 'courses.wharton',
    levelKey: 'courses.beginner',
    studentsKey: 'courses.studentsProduct',
    imageAsset: AppAssets.roadmapProductManagement,
    priceKey: 'courses.price49',
    durationKey: 'courses.duration4Weeks',
  ),
  Course(
    id: 'machine-learning',
    titleKey: 'courses.machineLearning',
    providerKey: 'courses.stanford',
    levelKey: 'courses.advancedLevel',
    studentsKey: 'courses.studentsMachine',
    imageAsset: AppAssets.roadmapMachineLearning,
    priceKey: 'courses.price120',
    durationKey: 'courses.duration12Weeks',
  ),
  Course(
    id: 'uiux-psychology',
    titleKey: 'courses.uiUxPsychology',
    providerKey: 'courses.interactionDesign',
    levelKey: 'courses.intermediate',
    studentsKey: 'courses.studentsUx',
    imageAsset: AppAssets.roadmapUiUxPsychology,
    priceKey: 'courses.price34',
    durationKey: 'courses.duration6Weeks',
  ),
  Course(
    id: 'advanced-react-design-patterns',
    titleKey: 'courses.reactPatterns',
    providerKey: 'courses.metaCertificate',
    levelKey: 'courses.advancedLevel',
    studentsKey: 'courses.studentsMachine',
    imageAsset: AppAssets.roadmapTopPickReact,
    priceKey: 'courses.price89',
    durationKey: 'courses.duration12h',
  ),
];

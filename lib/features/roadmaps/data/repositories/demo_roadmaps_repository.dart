import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/roadmap.dart';
import '../../domain/entities/roadmap_course_recommendation.dart';
import '../../domain/repositories/roadmaps_repository.dart';

class DemoRoadmapsRepository implements RoadmapsRepository {
  DemoRoadmapsRepository();

  Roadmap _roadmap = _demoRoadmap;

  @override
  Future<Either<Failure, List<RoadmapCourseRecommendation>>>
      getRoadmaps() async {
    return const Right(demoRecommendations);
  }

  @override
  Future<Either<Failure, Roadmap>> getRoadmapDetails(String id) async {
    if (id != _roadmap.id) {
      return const Left(ValidationFailure('roadmaps.invalidId'));
    }

    return Right(_roadmap);
  }

  @override
  Future<Either<Failure, Roadmap>> updateRoadmapStep({
    required String roadmapId,
    required String stepId,
    required RoadmapStepStatus status,
  }) async {
    if (roadmapId != _roadmap.id) {
      return const Left(ValidationFailure('roadmaps.invalidId'));
    }

    final steps = [
      for (final step in _roadmap.steps)
        step.id == stepId ? step.copyWith(status: status) : step,
    ];
    final completedCount = steps
        .where((step) => step.status == RoadmapStepStatus.completed)
        .length;

    _roadmap = _roadmap.copyWith(
      steps: steps,
      progressValue: completedCount / steps.length,
      progressLabelKey: 'roadmaps.detailProgress',
    );

    return Right(_roadmap);
  }
}

const demoRecommendations = [
  RoadmapCourseRecommendation(
    id: 'react-patterns',
    titleKey: 'courses.reactPatternsShort',
    providerKey: 'courses.metaCertificate',
    imageAsset: AppAssets.roadmapTopPickReact,
    matchLabel: 'roadmaps.match98',
    ratingKey: 'courses.rating49',
    durationKey: 'courses.duration12h',
  ),
  RoadmapCourseRecommendation(
    id: 'systems-engineering',
    titleKey: 'roadmaps.milestoneDesignSystems',
    providerKey: 'courses.metaCertificate',
    imageAsset: AppAssets.roadmapTopPickSystems,
    matchLabel: 'roadmaps.match94',
    ratingKey: 'courses.rating48',
    durationKey: 'courses.duration10h',
  ),
  RoadmapCourseRecommendation(
    id: 'machine-learning',
    titleKey: 'courses.machineLearning',
    providerKey: 'courses.stanford',
    imageAsset: AppAssets.roadmapMachineLearning,
    matchLabel: 'roadmaps.match94',
    ratingKey: 'courses.rating48',
    durationKey: 'courses.duration12Weeks',
  ),
];

const _demoRoadmap = Roadmap(
  id: 'react-mastery',
  titleKey: 'roadmaps.detailTitle',
  typeKey: 'roadmaps.pathType',
  durationKey: 'roadmaps.estimatedDuration',
  progressLabelKey: 'roadmaps.detailProgress',
  progressValue: .35,
  steps: [
    RoadmapStep(
      id: 'modern-web',
      titleKey: 'roadmaps.modernWeb',
      bodyKey: 'roadmaps.modernWebDescription',
      status: RoadmapStepStatus.completed,
    ),
    RoadmapStep(
      id: 'headless-ui',
      titleKey: 'roadmaps.headlessUi',
      bodyKey: 'roadmaps.webVitalsDescription',
      status: RoadmapStepStatus.inProgress,
      hasRecommendedCourse: true,
    ),
    RoadmapStep(
      id: 'web-vitals',
      titleKey: 'roadmaps.webVitals',
      bodyKey: 'roadmaps.webVitalsDescription',
      status: RoadmapStepStatus.inProgress,
    ),
    RoadmapStep(
      id: 'frontend-security',
      titleKey: 'roadmaps.frontendSecurity',
      bodyKey: 'roadmaps.frontendSecurityDescription',
      status: RoadmapStepStatus.upcoming,
    ),
  ],
);

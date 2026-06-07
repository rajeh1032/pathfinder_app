import 'package:equatable/equatable.dart';

import '../../domain/entities/roadmap.dart';
import '../../domain/entities/roadmap_course_recommendation.dart';

enum RoadmapsFilter { price, duration, level, all }

sealed class RoadmapsState extends Equatable {
  const RoadmapsState();

  @override
  List<Object?> get props => [];
}

class RoadmapsInitial extends RoadmapsState {
  const RoadmapsInitial();
}

class RoadmapsLoading extends RoadmapsState {
  const RoadmapsLoading();
}

class RoadmapsSuccess extends RoadmapsState {
  const RoadmapsSuccess({
    required this.recommendations,
    this.query = '',
    this.selectedFilter = RoadmapsFilter.all,
    this.selectedCategoryKey,
    this.savedCourseIds = const {},
  });

  final List<RoadmapCourseRecommendation> recommendations;
  final String query;
  final RoadmapsFilter selectedFilter;
  final String? selectedCategoryKey;
  final Set<String> savedCourseIds;

  @override
  List<Object?> get props => [
        recommendations,
        query,
        selectedFilter,
        selectedCategoryKey,
        savedCourseIds,
      ];
}

class RoadmapsEmpty extends RoadmapsState {
  const RoadmapsEmpty({
    this.query = '',
    this.selectedFilter = RoadmapsFilter.all,
    this.selectedCategoryKey,
  });

  final String query;
  final RoadmapsFilter selectedFilter;
  final String? selectedCategoryKey;

  @override
  List<Object?> get props => [query, selectedFilter, selectedCategoryKey];
}

class RoadmapsError extends RoadmapsState {
  const RoadmapsError({this.messageKey = 'common.error'});

  final String messageKey;

  @override
  List<Object?> get props => [messageKey];
}

class RoadmapDetailsSuccess extends RoadmapsState {
  const RoadmapDetailsSuccess({
    required this.roadmap,
    this.updatingStepId,
  });

  final Roadmap roadmap;
  final String? updatingStepId;

  @override
  List<Object?> get props => [roadmap, updatingStepId];
}

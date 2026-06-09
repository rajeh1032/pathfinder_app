import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/roadmap.dart';
import '../../domain/entities/roadmap_course_recommendation.dart';
import '../../domain/use_cases/get_roadmap_details_use_case.dart';
import '../../domain/use_cases/get_roadmaps_use_case.dart';
import '../../domain/use_cases/update_roadmap_step_use_case.dart';
import 'roadmaps_state.dart';

class RoadmapsCubit extends Cubit<RoadmapsState> {
  RoadmapsCubit({
    required GetRoadmapsUseCase getRoadmapsUseCase,
    required GetRoadmapDetailsUseCase getRoadmapDetailsUseCase,
    required UpdateRoadmapStepUseCase updateRoadmapStepUseCase,
  })  : _getRoadmapsUseCase = getRoadmapsUseCase,
        _getRoadmapDetailsUseCase = getRoadmapDetailsUseCase,
        _updateRoadmapStepUseCase = updateRoadmapStepUseCase,
        super(const RoadmapsInitial());

  final GetRoadmapsUseCase _getRoadmapsUseCase;
  final GetRoadmapDetailsUseCase _getRoadmapDetailsUseCase;
  final UpdateRoadmapStepUseCase _updateRoadmapStepUseCase;
  final Set<String> _savedCourseIds = {};

  List<RoadmapCourseRecommendation> _allRecommendations = const [];
  String _query = '';
  RoadmapsFilter _selectedFilter = RoadmapsFilter.all;
  String? _selectedCategoryKey;

  Future<void> loadRoadmaps() async {
    emit(const RoadmapsLoading());
    _query = '';
    _selectedFilter = RoadmapsFilter.all;
    _selectedCategoryKey = null;
    final result = await _getRoadmapsUseCase();

    result.fold(
      (failure) => emit(RoadmapsError(messageKey: failure.message)),
      (recommendations) {
        _allRecommendations = recommendations;
        _emitFilteredRoadmaps();
      },
    );
  }

  Future<void> loadRoadmapDetails(String id) async {
    emit(const RoadmapsLoading());
    final result = await _getRoadmapDetailsUseCase(id);

    result.fold(
      (failure) => emit(RoadmapsError(messageKey: failure.message)),
      (roadmap) => emit(RoadmapDetailsSuccess(roadmap: roadmap)),
    );
  }

  void searchRoadmaps(String query) {
    _query = query.trim();
    _emitFilteredRoadmaps();
  }

  void toggleFilter(RoadmapsFilter filter) {
    _selectedFilter = _selectedFilter == filter ? RoadmapsFilter.all : filter;
    _emitFilteredRoadmaps();
  }

  void selectCategory(String categoryKey) {
    _selectedCategoryKey =
        _selectedCategoryKey == categoryKey ? null : categoryKey;
    _emitFilteredRoadmaps();
  }

  bool toggleSavedCourse(String id) {
    if (_savedCourseIds.contains(id)) {
      _savedCourseIds.remove(id);
    } else {
      _savedCourseIds.add(id);
    }
    _emitFilteredRoadmaps();
    return _savedCourseIds.contains(id);
  }

  Future<bool?> toggleStepStatus(String stepId) async {
    final currentState = state;
    if (currentState is! RoadmapDetailsSuccess) return null;

    final step = currentState.roadmap.steps.firstWhere(
      (item) => item.id == stepId,
    );
    if (step.status == RoadmapStepStatus.upcoming) return null;

    final nextStatus = step.status == RoadmapStepStatus.completed
        ? RoadmapStepStatus.inProgress
        : RoadmapStepStatus.completed;

    emit(RoadmapDetailsSuccess(
      roadmap: currentState.roadmap,
      updatingStepId: stepId,
    ));
    final result = await _updateRoadmapStepUseCase(
      roadmapId: currentState.roadmap.id,
      stepId: stepId,
      status: nextStatus,
    );

    return result.fold(
      (failure) {
        emit(RoadmapsError(messageKey: failure.message));
        return null;
      },
      (roadmap) {
        emit(RoadmapDetailsSuccess(roadmap: roadmap));
        return nextStatus == RoadmapStepStatus.completed;
      },
    );
  }

  void _emitFilteredRoadmaps() {
    final filtered = _filteredRecommendations();
    if (filtered.isEmpty) {
      emit(RoadmapsEmpty(
        query: _query,
        selectedFilter: _selectedFilter,
        selectedCategoryKey: _selectedCategoryKey,
      ));
      return;
    }

    emit(
      RoadmapsSuccess(
        recommendations: filtered,
        query: _query,
        selectedFilter: _selectedFilter,
        selectedCategoryKey: _selectedCategoryKey,
        savedCourseIds: Set.unmodifiable(_savedCourseIds),
      ),
    );
  }

  List<RoadmapCourseRecommendation> _filteredRecommendations() {
    final query = _query.toLowerCase();
    final queried = query.isEmpty
        ? _allRecommendations
        : _allRecommendations.where((item) => _matchesQuery(item, query));
    final categorized = queried.where(_matchesCategory);
    final filtered = categorized.where(_matchesFilter).toList();

    filtered.sort((first, second) => switch (_selectedFilter) {
          RoadmapsFilter.duration =>
            first.durationKey.compareTo(second.durationKey),
          RoadmapsFilter.level => first.matchLabel.compareTo(second.matchLabel),
          RoadmapsFilter.price => first.ratingKey.compareTo(second.ratingKey),
          RoadmapsFilter.all => first.titleKey.compareTo(second.titleKey),
        });

    return filtered;
  }

  bool _matchesQuery(RoadmapCourseRecommendation item, String query) {
    return [item.id, item.titleKey, item.providerKey, item.durationKey]
        .any((value) => value.toLowerCase().contains(query));
  }

  bool _matchesCategory(RoadmapCourseRecommendation item) {
    return switch (_selectedCategoryKey) {
      'roadmaps.categoryDevelopment' => item.id.contains('react') ||
          item.titleKey.toLowerCase().contains('systems'),
      'roadmaps.categoryDataScience' => item.id.contains('machine'),
      null => true,
      _ => true,
    };
  }

  bool _matchesFilter(RoadmapCourseRecommendation item) {
    return switch (_selectedFilter) {
      RoadmapsFilter.price =>
        item.ratingKey.contains('49') || item.ratingKey.contains('48'),
      RoadmapsFilter.duration =>
        item.durationKey.contains('12') || item.durationKey.contains('10'),
      RoadmapsFilter.level =>
        item.matchLabel.contains('94') || item.matchLabel.contains('98'),
      RoadmapsFilter.all => true,
    };
  }
}

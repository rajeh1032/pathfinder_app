import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_profile_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required GetProfileUseCase getProfileUseCase})
      : _getProfileUseCase = getProfileUseCase,
        super(const ProfileInitial());

  final GetProfileUseCase _getProfileUseCase;
  final Set<String> _savedCourseIds = {};
  final Set<String> _savedJobIds = {};

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    final result = await _getProfileUseCase();

    result.fold(
      (failure) => emit(ProfileError(messageKey: failure.message)),
      (profile) {
        if (profile.fullNameKey.isEmpty) {
          emit(const ProfileEmpty());
          return;
        }
        _savedCourseIds
          ..clear()
          ..addAll(profile.savedCourses.map((course) => course.id));
        _savedJobIds
          ..clear()
          ..addAll(profile.savedJobs.map((job) => job.id));
        emit(ProfileSuccess(
          profile: profile,
          savedCourseIds: Set.unmodifiable(_savedCourseIds),
          savedJobIds: Set.unmodifiable(_savedJobIds),
        ));
      },
    );
  }

  bool toggleSavedCourse(String id) {
    _toggle(_savedCourseIds, id);
    _emitSavedState();
    return _savedCourseIds.contains(id);
  }

  bool toggleSavedJob(String id) {
    _toggle(_savedJobIds, id);
    _emitSavedState();
    return _savedJobIds.contains(id);
  }

  void _toggle(Set<String> ids, String id) {
    if (ids.contains(id)) {
      ids.remove(id);
    } else {
      ids.add(id);
    }
  }

  void _emitSavedState() {
    final currentState = state;
    if (currentState is! ProfileSuccess) return;

    emit(currentState.copyWith(
      savedCourseIds: Set.unmodifiable(_savedCourseIds),
      savedJobIds: Set.unmodifiable(_savedJobIds),
    ));
  }
}

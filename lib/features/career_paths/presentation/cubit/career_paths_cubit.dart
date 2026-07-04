import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_career_paths_use_case.dart';
import 'career_paths_state.dart';

@injectable
class CareerPathsCubit extends Cubit<CareerPathsState> {
  CareerPathsCubit(this._getCareerPathsUseCase)
      : super(const CareerPathsState());

  final GetCareerPathsUseCase _getCareerPathsUseCase;

  Future<void> load() async {
    if (state.isLoading) return;
    emit(state.copyWith(status: CareerPathsStatus.loading));

    final result = await _getCareerPathsUseCase();

    result.fold(
      (failure) => emit(state.copyWith(
        status: CareerPathsStatus.failure,
        errorMessage: failure.message,
      )),
      (paths) => emit(state.copyWith(
        status: CareerPathsStatus.success,
        careerPaths: paths,
      )),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/home_repo.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(const HomeInitial());

  Future<void> loadHome() async {
    emit(const HomeLoading());
    try {
      final summary = await repository.getHomeSummary();
      emit(HomeLoaded(summary));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> refresh() => loadHome();
}
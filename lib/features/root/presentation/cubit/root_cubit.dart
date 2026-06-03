import 'package:flutter_bloc/flutter_bloc.dart';

import 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(const RootState());

  void changeTab(int index) => emit(state.copyWith(selectedIndex: index));
}

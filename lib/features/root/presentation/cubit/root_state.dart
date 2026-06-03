import 'package:equatable/equatable.dart';

class RootState extends Equatable {
  const RootState({this.selectedIndex = 0});

  final int selectedIndex;

  RootState copyWith({int? selectedIndex}) {
    return RootState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  @override
  List<Object?> get props => [selectedIndex];
}

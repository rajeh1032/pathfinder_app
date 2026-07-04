import 'package:equatable/equatable.dart';

import '../../domain/entities/career_path.dart';

enum CareerPathsStatus { initial, loading, success, failure }

class CareerPathsState extends Equatable {
  const CareerPathsState({
    this.status = CareerPathsStatus.initial,
    this.careerPaths = const [],
    this.errorMessage,
  });

  final CareerPathsStatus status;
  final List<CareerPath> careerPaths;
  final String? errorMessage;

  bool get isLoading => status == CareerPathsStatus.loading;
  bool get isSuccess => status == CareerPathsStatus.success;
  bool get isFailure => status == CareerPathsStatus.failure;

  CareerPathsState copyWith({
    CareerPathsStatus? status,
    List<CareerPath>? careerPaths,
    String? errorMessage,
  }) {
    return CareerPathsState(
      status: status ?? this.status,
      careerPaths: careerPaths ?? this.careerPaths,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, careerPaths, errorMessage];
}

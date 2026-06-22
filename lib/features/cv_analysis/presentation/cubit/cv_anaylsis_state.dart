import 'package:equatable/equatable.dart';
import '../../domain/entities/cv_anaysis_entity.dart';

abstract class CvAnalysisState extends Equatable {
  const CvAnalysisState();

  @override
  List<Object?> get props => [];
}

// ── Initial

class CvAnalysisInitial extends CvAnalysisState {
  const CvAnalysisInitial();
}

// ── Status Check

class CvStatusLoading extends CvAnalysisState {
  const CvStatusLoading();
}

class CvStatusLoaded extends CvAnalysisState {
  final CvStatusEntity status;

  const CvStatusLoaded(this.status);

  @override
  List<Object?> get props => [status];
}

//  Upload
class CvUploadLoading extends CvAnalysisState {
  final double progress; // 0.0 → 1.0

  const CvUploadLoading({this.progress = 0.0});

  @override
  List<Object?> get props => [progress];
}

// Analyzing (waiting on Gemini result)

class CvAnalyzing extends CvAnalysisState {
  const CvAnalyzing();
}

class CvAnalysisLoaded extends CvAnalysisState {
  final CvWithAnalysisEntity result;

  const CvAnalysisLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class CvAnalysisError extends CvAnalysisState {
  final String message;

  const CvAnalysisError(this.message);

  @override
  List<Object?> get props => [message];
}
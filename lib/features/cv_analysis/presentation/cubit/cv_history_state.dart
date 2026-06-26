import 'package:equatable/equatable.dart';

import '../../domain/entities/cv_anaysis_entity.dart';

abstract class CvHistoryState extends Equatable {
  const CvHistoryState();

  @override
  List<Object?> get props => [];
}

class CvHistoryInitial extends CvHistoryState {
  const CvHistoryInitial();
}

class CvHistoryLoading extends CvHistoryState {
  const CvHistoryLoading();
}

class CvHistoryLoaded extends CvHistoryState {
  const CvHistoryLoaded(this.items, {this.openingCvId});

  final List<CvHistoryItemEntity> items;
  final String? openingCvId;

  @override
  List<Object?> get props => [items, openingCvId];
}

class CvHistoryEmpty extends CvHistoryState {
  const CvHistoryEmpty();
}

class CvHistoryFileReady extends CvHistoryState {
  const CvHistoryFileReady({required this.items, required this.file});

  final List<CvHistoryItemEntity> items;
  final CvFileUrlEntity file;

  @override
  List<Object?> get props => [items, file];
}

class CvHistoryError extends CvHistoryState {
  const CvHistoryError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

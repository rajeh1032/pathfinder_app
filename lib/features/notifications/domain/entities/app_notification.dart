import 'package:equatable/equatable.dart';

enum NotificationCategory { job, interview, insight, learning, document }

class AppNotification extends Equatable {
  const AppNotification({
    required this.id,
    required this.category,
    required this.labelKey,
    required this.titleKey,
    required this.bodyKey,
    required this.timeKey,
    required this.isRead,
    this.actionLabelKey,
    this.progress,
    this.progressLabelKey,
    this.scoreKey,
    this.sectionKey,
  });

  final String id;
  final NotificationCategory category;
  final String labelKey;
  final String titleKey;
  final String bodyKey;
  final String timeKey;
  final bool isRead;
  final String? actionLabelKey;
  final double? progress;
  final String? progressLabelKey;
  final String? scoreKey;
  final String? sectionKey;

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      category: category,
      labelKey: labelKey,
      titleKey: titleKey,
      bodyKey: bodyKey,
      timeKey: timeKey,
      isRead: isRead ?? this.isRead,
      actionLabelKey: actionLabelKey,
      progress: progress,
      progressLabelKey: progressLabelKey,
      scoreKey: scoreKey,
      sectionKey: sectionKey,
    );
  }

  @override
  List<Object?> get props => [
        id,
        category,
        labelKey,
        titleKey,
        bodyKey,
        timeKey,
        isRead,
        actionLabelKey,
        progress,
        progressLabelKey,
        scoreKey,
        sectionKey,
      ];
}

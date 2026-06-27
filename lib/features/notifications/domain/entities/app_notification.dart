import 'package:equatable/equatable.dart';

/// Notification categories supported by the backend.
/// Keep in sync with `NOTIFICATION_CATEGORIES` in the backend schema.
enum NotificationCategory { job, interview, insight, learning, document, other }

class AppNotification extends Equatable {
  const AppNotification({
    required this.id,
    required this.type,
    required this.category,
    required this.title,
    required this.createdAt,
    required this.isRead,
    this.body,
    this.actionLabel,
    this.actionUrl,
    this.metadata = const {},
    this.readAt,
    this.progress,
    this.score,
  });

  final String id;
  final String type;
  final NotificationCategory category;
  final String title;
  final DateTime createdAt;
  final bool isRead;
  final String? body;
  final String? actionLabel;
  final String? actionUrl;
  final Map<String, dynamic> metadata;
  final DateTime? readAt;

  /// Optional learning progress (0.0 - 1.0), derived from metadata.
  final double? progress;

  /// Optional score badge text (e.g. "82/100"), derived from metadata.
  final String? score;

  bool get hasAction => actionLabel != null && actionLabel!.trim().isNotEmpty;

  AppNotification copyWith({bool? isRead, DateTime? readAt}) {
    return AppNotification(
      id: id,
      type: type,
      category: category,
      title: title,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
      body: body,
      actionLabel: actionLabel,
      actionUrl: actionUrl,
      metadata: metadata,
      readAt: readAt ?? this.readAt,
      progress: progress,
      score: score,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        category,
        title,
        createdAt,
        isRead,
        body,
        actionLabel,
        actionUrl,
        metadata,
        readAt,
        progress,
        score,
      ];
}

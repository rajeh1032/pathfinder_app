import '../../domain/entities/app_notification.dart';

/// Data model for a notification returned by the backend.
/// Does not extend the domain entity; use [toEntity] to convert.
class NotificationModel {
  const NotificationModel({
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
  });

  final String id;
  final String type;
  final String category;
  final String title;
  final String createdAt;
  final bool isRead;
  final String? body;
  final String? actionLabel;
  final String? actionUrl;
  final Map<String, dynamic> metadata;
  final String? readAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'];
    return NotificationModel(
      id: _string(json['id']),
      type: _string(json['type']),
      category: _string(json['category']),
      title: _string(json['title'], fallback: ''),
      createdAt: _string(json['created_at']),
      isRead: json['is_read'] == true,
      body: _nullableString(json['body']),
      actionLabel: _nullableString(json['action_label']),
      actionUrl: _nullableString(json['action_url']),
      metadata: metadata is Map<String, dynamic> ? metadata : const {},
      readAt: _nullableString(json['read_at']),
    );
  }

  AppNotification toEntity() {
    return AppNotification(
      id: id,
      type: type,
      category: _categoryFromString(category),
      title: title,
      createdAt: DateTime.tryParse(createdAt)?.toLocal() ?? DateTime.now(),
      isRead: isRead,
      body: body,
      actionLabel: actionLabel,
      actionUrl: actionUrl,
      metadata: metadata,
      readAt: readAt == null ? null : DateTime.tryParse(readAt!)?.toLocal(),
      progress: _progressFromMetadata(metadata),
      score: _scoreFromMetadata(metadata),
    );
  }
}

NotificationCategory _categoryFromString(String value) {
  return switch (value.toLowerCase()) {
    'job' => NotificationCategory.job,
    'interview' => NotificationCategory.interview,
    'insight' => NotificationCategory.insight,
    'learning' => NotificationCategory.learning,
    'document' => NotificationCategory.document,
    _ => NotificationCategory.other,
  };
}

double? _progressFromMetadata(Map<String, dynamic> metadata) {
  final raw = metadata['progress'];
  if (raw is num) {
    final value = raw.toDouble();
    final fraction = value > 1 ? value / 100 : value;
    return fraction.clamp(0.0, 1.0);
  }
  return null;
}

String? _scoreFromMetadata(Map<String, dynamic> metadata) {
  final raw = metadata['score'];
  if (raw == null) return null;
  final text = raw.toString().trim();
  return text.isEmpty ? null : text;
}

String _string(Object? value, {String fallback = ''}) {
  if (value == null) return fallback;
  final text = value.toString();
  return text.isEmpty ? fallback : text;
}

String? _nullableString(Object? value) {
  if (value == null) return null;
  final text = value.toString();
  return text.isEmpty ? null : text;
}

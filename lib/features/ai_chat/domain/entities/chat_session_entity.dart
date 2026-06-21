class ChatSessionEntity {
  final String id;
  final String userId;
  final String title;
  final String status; // active | archived | deleted
  final DateTime createdAt;
  final DateTime updatedAt;

  const ChatSessionEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == 'active';

  factory ChatSessionEntity.fromJson(Map<String, dynamic> json) {
    return ChatSessionEntity(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String? ?? 'New chat',
      status: json['status'] as String? ?? 'active',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
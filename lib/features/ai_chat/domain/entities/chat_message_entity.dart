class ChatMessageEntity {
  final String id;
  final String sessionId;
  final String sender;
  final String message;
  final int? tokens;
  final DateTime createdAt;

  const ChatMessageEntity({
    required this.id,
    required this.sessionId,
    required this.sender,
    required this.message,
    this.tokens,
    required this.createdAt,
  });

  bool get isFromUser => sender == 'user';

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
      id: json['id'],
      sessionId: json['session_id'] ?? '',
      sender: json['sender'],
      message: json['message'],
      tokens: json['tokens'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
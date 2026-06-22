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
      id: json['id'] as String? ??
          'temp-${DateTime.now().millisecondsSinceEpoch}',
      sessionId: json['session_id'] as String? ?? '',
      sender: json['sender'] as String? ?? 'assistant',
      message: json['message'] as String? ?? '',
      tokens: json['tokens'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }
}
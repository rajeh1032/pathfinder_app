class ChatSessionModel {
  final String id;
  final String title;
  final String preview;
  final String date;
  final int messageCount;
  final bool isActive;
  final String tag;

  const ChatSessionModel({
    required this.id,
    required this.title,
    required this.preview,
    required this.date,
    required this.messageCount,
    required this.isActive,
    required this.tag,
  });
}
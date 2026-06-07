class ChatMessage {
  final String text;
  final bool isFromUser;
  final String time;

  const ChatMessage({
    required this.text,
    required this.isFromUser,
    required this.time,
  });
}

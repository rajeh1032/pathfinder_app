import 'package:equatable/equatable.dart';

class ChatSessionEntity extends Equatable {
  const ChatSessionEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String title;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isActive => status == 'active';

  @override
  List<Object?> get props => [id, userId, title, status, createdAt, updatedAt];
}

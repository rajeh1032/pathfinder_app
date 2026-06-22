import 'package:equatable/equatable.dart';

class InterviewCareerPath extends Equatable {
  const InterviewCareerPath({
    required this.id,
    required this.name,
    this.description,
    this.iconName,
  });

  final String id;
  final String name;
  final String? description;
  final String? iconName;

  InterviewCareerPath copyWith({
    String? id,
    String? name,
    String? description,
    String? iconName,
  }) {
    return InterviewCareerPath(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
    );
  }

  @override
  List<Object?> get props => [id, name, description, iconName];
}

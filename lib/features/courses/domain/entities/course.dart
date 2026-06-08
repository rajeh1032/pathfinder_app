import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.titleKey,
    required this.providerKey,
    required this.levelKey,
    required this.studentsKey,
    required this.imageAsset,
    required this.priceKey,
    required this.durationKey,
  });

  final String id;
  final String titleKey;
  final String providerKey;
  final String levelKey;
  final String studentsKey;
  final String imageAsset;
  final String priceKey;
  final String durationKey;

  Course copyWith({
    String? id,
    String? titleKey,
    String? providerKey,
    String? levelKey,
    String? studentsKey,
    String? imageAsset,
    String? priceKey,
    String? durationKey,
  }) {
    return Course(
      id: id ?? this.id,
      titleKey: titleKey ?? this.titleKey,
      providerKey: providerKey ?? this.providerKey,
      levelKey: levelKey ?? this.levelKey,
      studentsKey: studentsKey ?? this.studentsKey,
      imageAsset: imageAsset ?? this.imageAsset,
      priceKey: priceKey ?? this.priceKey,
      durationKey: durationKey ?? this.durationKey,
    );
  }

  @override
  List<Object?> get props => [
        id,
        titleKey,
        providerKey,
        levelKey,
        studentsKey,
        imageAsset,
        priceKey,
        durationKey,
      ];
}

import 'package:equatable/equatable.dart';

class RoadmapCourseRecommendation extends Equatable {
  const RoadmapCourseRecommendation({
    required this.id,
    required this.titleKey,
    required this.providerKey,
    required this.imageAsset,
    required this.matchLabel,
    required this.ratingKey,
    required this.durationKey,
  });

  final String id;
  final String titleKey;
  final String providerKey;
  final String imageAsset;
  final String matchLabel;
  final String ratingKey;
  final String durationKey;

  @override
  List<Object?> get props => [
        id,
        titleKey,
        providerKey,
        imageAsset,
        matchLabel,
        ratingKey,
        durationKey,
      ];
}

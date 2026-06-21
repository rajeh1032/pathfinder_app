import '../../domain/entities/roadmap.dart';
import 'model_parsing.dart';
import 'roadmap_step_model.dart';

class RoadmapSectionModel {
  const RoadmapSectionModel({
    required this.title,
    required this.status,
    required this.subtitle,
    required this.items,
  });

  factory RoadmapSectionModel.fromJson(Map<String, dynamic> json) {
    return RoadmapSectionModel(
      title: requiredString(json, 'title'),
      status: stepStatusFromJson(json['status']),
      subtitle: requiredString(json, 'subtitle'),
      items: mapList(json['items'], 'items')
          .map(RoadmapStepModel.fromJson)
          .toList(growable: false),
    );
  }

  final String title;
  final RoadmapStepStatus status;
  final String subtitle;
  final List<RoadmapStepModel> items;

  RoadmapSection toEntity() => RoadmapSection(
        title: title,
        status: status,
        subtitle: subtitle,
        items: List.unmodifiable(items.map((item) => item.toEntity())),
      );
}

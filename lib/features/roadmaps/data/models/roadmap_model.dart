import '../../domain/entities/roadmap.dart';
import 'model_parsing.dart';
import 'roadmap_insights_model.dart';
import 'roadmap_section_model.dart';

class RoadmapModel {
  const RoadmapModel({
    required this.id,
    required this.title,
    required this.description,
    required this.label,
    required this.estimatedDuration,
    required this.progress,
    required this.nextStep,
    required this.sections,
    required this.insights,
  });

  factory RoadmapModel.fromJson(Map<String, dynamic> json) {
    return RoadmapModel(
      id: requiredString(json, 'id'),
      title: requiredString(json, 'title'),
      description: requiredString(json, 'description'),
      label: requiredString(json, 'label'),
      estimatedDuration: requiredString(json, 'estimatedDuration'),
      progress: requiredInt(json, 'progress', min: 0, max: 100),
      nextStep: nullableString(json['nextStep']),
      sections: mapList(json['sections'], 'sections')
          .map(RoadmapSectionModel.fromJson)
          .toList(growable: false),
      insights: RoadmapInsightsModel.fromJson(json['insights']),
    );
  }

  final String id;
  final String title;
  final String description;
  final String label;
  final String estimatedDuration;
  final int progress;
  final String? nextStep;
  final List<RoadmapSectionModel> sections;
  final RoadmapInsightsModel insights;

  Roadmap toEntity() => Roadmap(
        id: id,
        title: title,
        description: description,
        label: label,
        estimatedDuration: estimatedDuration,
        progress: progress,
        nextStep: nextStep,
        sections: List.unmodifiable(sections.map((section) => section.toEntity())),
        insights: insights.toEntity(),
      );
}

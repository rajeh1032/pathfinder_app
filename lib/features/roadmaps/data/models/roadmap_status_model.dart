import '../../domain/entities/roadmap_status.dart';
import 'model_parsing.dart';
import 'roadmap_model.dart';

class RoadmapStatusModel {
  const RoadmapStatusModel({
    required this.hasRoadmap,
    required this.requiredAction,
    required this.roadmap,
  });

  factory RoadmapStatusModel.fromJson(Map<String, dynamic> json) {
    final hasRoadmap = json['hasRoadmap'];
    if (hasRoadmap is! bool) {
      throw const FormatException('Invalid hasRoadmap');
    }
    final roadmapJson = json['roadmap'];
    final roadmap = roadmapJson == null
        ? null
        : RoadmapModel.fromJson(requiredMap(roadmapJson, 'roadmap'));
    final action = requiredActionFromJson(json['requiredAction']);
    if (hasRoadmap != (roadmap != null) || (!hasRoadmap && action == null)) {
      throw const FormatException('Inconsistent roadmap status');
    }
    return RoadmapStatusModel(
      hasRoadmap: hasRoadmap,
      requiredAction: action,
      roadmap: roadmap,
    );
  }

  final bool hasRoadmap;
  final RequiredRoadmapAction? requiredAction;
  final RoadmapModel? roadmap;

  RoadmapStatus toEntity() => RoadmapStatus(
        hasRoadmap: hasRoadmap,
        requiredAction: requiredAction,
        roadmap: roadmap?.toEntity(),
      );
}

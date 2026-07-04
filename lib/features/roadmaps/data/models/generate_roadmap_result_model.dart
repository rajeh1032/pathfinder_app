import '../../domain/entities/roadmap_status.dart';
import 'model_parsing.dart';
import 'roadmap_model.dart';

class GenerateRoadmapResultModel {
  const GenerateRoadmapResultModel({
    required this.requiredAction,
    required this.reused,
    required this.roadmap,
  });

  factory GenerateRoadmapResultModel.fromJson(Map<String, dynamic> json) {
    final hasRoadmap = json['hasRoadmap'];
    if (hasRoadmap is! bool) {
      throw const FormatException('Invalid hasRoadmap');
    }
    final roadmapJson = json['roadmap'];
    final roadmap = roadmapJson == null
        ? null
        : RoadmapModel.fromJson(requiredMap(roadmapJson, 'roadmap'));
    final action = requiredActionFromJson(json['requiredAction']);
    final reusedValue = json['reused'];
    if (reusedValue is! bool) {
      throw const FormatException('Invalid reused');
    }
    if (hasRoadmap != (roadmap != null) || (!hasRoadmap && action == null)) {
      throw const FormatException('Generate result has no outcome');
    }
    return GenerateRoadmapResultModel(
      requiredAction: action,
      reused: reusedValue,
      roadmap: roadmap,
    );
  }

  final RequiredRoadmapAction? requiredAction;
  final bool reused;
  final RoadmapModel? roadmap;

  GenerateRoadmapResult toEntity() => GenerateRoadmapResult(
        requiredAction: requiredAction,
        reused: reused,
        roadmap: roadmap?.toEntity(),
      );
}

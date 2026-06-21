import 'package:equatable/equatable.dart';

import 'roadmap.dart';

enum RequiredRoadmapAction { uploadCv, generateRoadmap }

class RoadmapStatus extends Equatable {
  const RoadmapStatus({
    required this.hasRoadmap,
    required this.requiredAction,
    required this.roadmap,
  });

  final bool hasRoadmap;
  final RequiredRoadmapAction? requiredAction;
  final Roadmap? roadmap;

  @override
  List<Object?> get props => [hasRoadmap, requiredAction, roadmap];
}

class GenerateRoadmapResult extends Equatable {
  const GenerateRoadmapResult({
    required this.requiredAction,
    required this.reused,
    required this.roadmap,
  });

  final RequiredRoadmapAction? requiredAction;
  final bool reused;
  final Roadmap? roadmap;

  @override
  List<Object?> get props => [requiredAction, reused, roadmap];
}

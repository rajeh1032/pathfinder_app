import '../../domain/entities/roadmap.dart';
import 'model_parsing.dart';

class RoadmapInsightsModel {
  const RoadmapInsightsModel({
    required this.projectedSalaryIncrease,
    required this.matchingSeniorRoles,
  });

  factory RoadmapInsightsModel.fromJson(Object? value) {
    if (value == null) {
      return const RoadmapInsightsModel(
        projectedSalaryIncrease: 0,
        matchingSeniorRoles: 0,
      );
    }
    final json = requiredMap(value, 'insights');
    return RoadmapInsightsModel(
      projectedSalaryIncrease: requiredInt(
        json,
        'projectedSalaryIncrease',
        min: 0,
        max: 100,
      ),
      matchingSeniorRoles: requiredInt(json, 'matchingSeniorRoles', min: 0),
    );
  }

  final int projectedSalaryIncrease;
  final int matchingSeniorRoles;

  RoadmapInsights toEntity() => RoadmapInsights(
        projectedSalaryIncrease: projectedSalaryIncrease,
        matchingSeniorRoles: matchingSeniorRoles,
      );
}

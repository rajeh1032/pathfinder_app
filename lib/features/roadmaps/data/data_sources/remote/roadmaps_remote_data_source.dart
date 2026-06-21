import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/generate_roadmap_result_model.dart';
import '../../models/model_parsing.dart';
import '../../models/roadmap_model.dart';
import '../../models/roadmap_status_model.dart';

abstract class RoadmapsRemoteDataSource {
  Future<RoadmapStatusModel> getMyRoadmap();

  Future<GenerateRoadmapResultModel> generateRoadmap({
    bool forceRegenerate = false,
  });

  Future<RoadmapModel> getRoadmapDetails(String roadmapId);

  Future<RoadmapModel> updateStepProgress({
    required String roadmapId,
    required String stepId,
    required int progress,
    bool? isCompleted,
  });
}

@LazySingleton(as: RoadmapsRemoteDataSource)
class RoadmapsRemoteDataSourceImpl implements RoadmapsRemoteDataSource {
  const RoadmapsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<RoadmapStatusModel> getMyRoadmap() async {
    final response = await _apiClient.get(ApiEndpoints.myRoadmap);
    return RoadmapStatusModel.fromJson(_dataEnvelope(response.data));
  }

  @override
  Future<GenerateRoadmapResultModel> generateRoadmap({
    bool forceRegenerate = false,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.generateRoadmap,
      data: {'forceRegenerate': forceRegenerate},
    );
    return GenerateRoadmapResultModel.fromJson(_dataEnvelope(response.data));
  }

  @override
  Future<RoadmapModel> getRoadmapDetails(String roadmapId) async {
    final response = await _apiClient.get(
      ApiEndpoints.roadmapDetails(roadmapId),
    );
    return _roadmapFromEnvelope(response.data);
  }

  @override
  Future<RoadmapModel> updateStepProgress({
    required String roadmapId,
    required String stepId,
    required int progress,
    bool? isCompleted,
  }) async {
    final response = await _apiClient.patch(
      ApiEndpoints.roadmapStepProgress(roadmapId, stepId),
      data: {
        'progress': progress,
        if (isCompleted != null) 'isCompleted': isCompleted,
      },
    );
    return _roadmapFromEnvelope(response.data);
  }

  RoadmapModel _roadmapFromEnvelope(Object? body) {
    final data = _dataEnvelope(body);
    return RoadmapModel.fromJson(requiredMap(data['roadmap'], 'roadmap'));
  }

  Map<String, dynamic> _dataEnvelope(Object? body) {
    final envelope = requiredMap(body, 'response');
    if (envelope['success'] != true) {
      throw const FormatException('Unexpected unsuccessful response');
    }
    return requiredMap(envelope['data'], 'data');
  }
}

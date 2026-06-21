import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/career_path_model.dart';

abstract class CareerPathsRemoteDataSource {
  Future<List<CareerPathModel>> getCareerPaths();
}

@LazySingleton(as: CareerPathsRemoteDataSource)
class CareerPathsRemoteDataSourceImpl implements CareerPathsRemoteDataSource {
  const CareerPathsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<CareerPathModel>> getCareerPaths() async {
    final response = await _apiClient.get(ApiEndpoints.careerPaths);
    final body = response.data;

    // Handle both { data: [...] } and plain [...] response shapes
    final List<dynamic> list = switch (body) {
      {'data': final List<dynamic> d} => d,
      final List<dynamic> d => d,
      _ => throw const FormatException('Unexpected career paths response format'),
    };

    return list
        .whereType<Map<String, dynamic>>()
        .map(CareerPathModel.fromJson)
        .toList();
  }
}

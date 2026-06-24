import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/cover_letter_model.dart';

abstract class CoverLettersRemoteDataSource {
  Future<CoverLetterModel> generateCoverLetter({
    required String jobId,
    String tone = 'professional',
    List<String> keywords = const [],
    String companyInterest = '',
    String achievement = '',
    String language = 'en',
  });

  Future<List<CoverLetterModel>> getCoverLetters(
      {int page = 1, int limit = 20});

  Future<CoverLetterModel> getCoverLetter(String id);

  Future<CoverLetterModel> updateCoverLetter({
    required String id,
    required String content,
  });

  Future<CoverLetterModel> exportCoverLetter(String id);

  Future<void> deleteCoverLetter(String id);
}

class CoverLettersRemoteDataSourceImpl implements CoverLettersRemoteDataSource {
  const CoverLettersRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<CoverLetterModel> generateCoverLetter({
    required String jobId,
    String tone = 'professional',
    List<String> keywords = const [],
    String companyInterest = '',
    String achievement = '',
    String language = 'en',
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.generateCoverLetter,
      data: {
        'jobId': jobId,
        'tone': tone,
        'keywords': keywords,
        'companyInterest': companyInterest,
        'achievement': achievement,
        'language': language,
      },
    );
    return CoverLetterModel.fromJson(_object(response.data));
  }

  @override
  Future<List<CoverLetterModel>> getCoverLetters({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.get(
      ApiEndpoints.coverLetters,
      queryParameters: {'page': page, 'limit': limit},
    );
    return _list(response.data)
        .whereType<Map<String, dynamic>>()
        .map(CoverLetterModel.fromJson)
        .toList(growable: false);
  }

  @override
  Future<CoverLetterModel> getCoverLetter(String id) async {
    final response = await _apiClient.get(ApiEndpoints.coverLetterDetails(id));
    return CoverLetterModel.fromJson(_object(response.data));
  }

  @override
  Future<CoverLetterModel> updateCoverLetter({
    required String id,
    required String content,
  }) async {
    final response = await _apiClient.patch(
      ApiEndpoints.coverLetterDetails(id),
      data: {'content': content, 'status': 'edited'},
    );
    return CoverLetterModel.fromJson(_object(response.data));
  }

  @override
  Future<CoverLetterModel> exportCoverLetter(String id) async {
    final response = await _apiClient.post(ApiEndpoints.coverLetterExport(id));
    return CoverLetterModel.fromJson(_object(response.data));
  }

  @override
  Future<void> deleteCoverLetter(String id) async {
    await _apiClient.delete(ApiEndpoints.coverLetterDetails(id));
  }
}

Map<String, dynamic> _object(Object? body) {
  return switch (body) {
    {'data': final Map<String, dynamic> data} => data,
    final Map<String, dynamic> data => data,
    _ => throw const FormatException('Unexpected cover letter response format'),
  };
}

List<dynamic> _list(Object? body) {
  return switch (body) {
    {'data': final List<dynamic> data} => data,
    final List<dynamic> data => data,
    _ =>
      throw const FormatException('Unexpected cover letters response format'),
  };
}

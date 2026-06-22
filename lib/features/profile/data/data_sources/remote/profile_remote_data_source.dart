import 'package:injectable/injectable.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../domain/entities/education_entry.dart';
import '../../../domain/entities/work_experience.dart';
import '../../models/education_entry_model.dart';
import '../../models/user_profile_model.dart';
import '../../models/work_experience_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getMyProfile();
  Future<UserProfileModel> updateMyProfile(Map<String, dynamic> changes);

  Future<List<WorkExperienceModel>> getExperiences();
  Future<WorkExperienceModel> createExperience(WorkExperienceInput input);
  Future<WorkExperienceModel> updateExperience(
    String id,
    WorkExperienceInput input,
  );
  Future<String> deleteExperience(String id);

  Future<List<EducationEntryModel>> getEducation();
  Future<EducationEntryModel> createEducation(EducationInput input);
  Future<EducationEntryModel> updateEducation(String id, EducationInput input);
  Future<bool> deleteEducation(String id);
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  // ── Profile ───────────────────────────────────────────────────────────
  @override
  Future<UserProfileModel> getMyProfile() async {
    final response = await _apiClient.get(ApiEndpoints.profileMe);
    return UserProfileModel.fromJson(_dataMap(response.data)['profile']);
  }

  @override
  Future<UserProfileModel> updateMyProfile(
    Map<String, dynamic> changes,
  ) async {
    final response =
        await _apiClient.patch(ApiEndpoints.profileMe, data: changes);
    return UserProfileModel.fromJson(_dataMap(response.data)['profile']);
  }

  // ── Experiences (wrapped: data.experience / data.experiences) ──────────
  @override
  Future<List<WorkExperienceModel>> getExperiences() async {
    final response = await _apiClient.get(ApiEndpoints.profileExperiences);
    final list = _dataMap(response.data)['experiences'] as List? ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(WorkExperienceModel.fromJson)
        .toList();
  }

  @override
  Future<WorkExperienceModel> createExperience(
    WorkExperienceInput input,
  ) async {
    final response = await _apiClient.post(
      ApiEndpoints.profileExperiences,
      data: WorkExperienceModel.inputToJson(input),
    );
    return WorkExperienceModel.fromJson(_dataMap(response.data)['experience']);
  }

  @override
  Future<WorkExperienceModel> updateExperience(
    String id,
    WorkExperienceInput input,
  ) async {
    final response = await _apiClient.patch(
      ApiEndpoints.profileExperienceById(id),
      data: WorkExperienceModel.inputToJson(input),
    );
    return WorkExperienceModel.fromJson(_dataMap(response.data)['experience']);
  }

  @override
  Future<String> deleteExperience(String id) async {
    final response =
        await _apiClient.delete(ApiEndpoints.profileExperienceById(id));
    return _dataMap(response.data)['id'] as String? ?? id;
  }

  // ── Education (raw: data is the object/array directly) ──────────────────
  @override
  Future<List<EducationEntryModel>> getEducation() async {
    final response = await _apiClient.get(ApiEndpoints.profileEducation);
    final data = _envelope(response.data)['data'] as List? ?? const [];
    return data
        .whereType<Map<String, dynamic>>()
        .map(EducationEntryModel.fromJson)
        .toList();
  }

  @override
  Future<EducationEntryModel> createEducation(EducationInput input) async {
    final response = await _apiClient.post(
      ApiEndpoints.profileEducation,
      data: EducationEntryModel.inputToJson(input),
    );
    return EducationEntryModel.fromJson(_dataMap(response.data));
  }

  @override
  Future<EducationEntryModel> updateEducation(
    String id,
    EducationInput input,
  ) async {
    final response = await _apiClient.patch(
      ApiEndpoints.profileEducationById(id),
      data: EducationEntryModel.inputToJson(input),
    );
    return EducationEntryModel.fromJson(_dataMap(response.data));
  }

  @override
  Future<bool> deleteEducation(String id) async {
    final response =
        await _apiClient.delete(ApiEndpoints.profileEducationById(id));
    return _dataMap(response.data)['deleted'] == true;
  }

  // ── Helpers ─────────────────────────────────────────────────────────────

  /// Returns the full `{ success, message, data, ... }` envelope.
  Map<String, dynamic> _envelope(dynamic body) {
    if (body is Map<String, dynamic>) return body;
    throw const FormatException('Unexpected profile response format');
  }

  /// Returns the `data` object as a map. Use for endpoints whose `data`
  /// is an object (profile, single experience/education).
  Map<String, dynamic> _dataMap(dynamic body) {
    final data = _envelope(body)['data'];
    if (data is Map<String, dynamic>) return data;
    throw const FormatException('Unexpected profile response data format');
  }
}

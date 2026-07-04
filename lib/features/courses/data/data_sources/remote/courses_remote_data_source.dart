import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../domain/entities/course_enrollment.dart';
import '../../../domain/entities/courses_query.dart';
import '../../models/course_model.dart';
import '../../models/course_model_parsing.dart';
import '../../models/course_mutation_models.dart';
import '../../models/courses_page_model.dart';
import '../../models/recommended_courses_result_model.dart';

abstract class CoursesRemoteDataSource {
  Future<CoursesPageModel> getCourses(CoursesQuery query);
  Future<CourseModel> getCourseDetails(String courseId);
  Future<RecommendedCoursesResultModel> getRecommendedCourses(int limit);
  Future<CoursesPageModel> getSavedCourses(int page, int limit);
  Future<CoursesPageModel> getEnrollments(int page, int limit);
  Future<SavedCourseResultModel> saveCourse(String courseId);
  Future<SavedCourseResultModel> unsaveCourse(String courseId);
  Future<EnrollmentMutationResultModel> enrollCourse(String courseId);
  Future<EnrollmentMutationResultModel> updateEnrollment(
    String courseId, {
    int? progress,
    EnrollmentStatus? status,
  });
}

@LazySingleton(as: CoursesRemoteDataSource)
class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  const CoursesRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<CoursesPageModel> getCourses(CoursesQuery query) async {
    final response = await _apiClient.get(
      ApiEndpoints.courses,
      queryParameters: query.toQueryParameters(),
    );
    return _page(response.data);
  }

  @override
  Future<CourseModel> getCourseDetails(String courseId) async {
    final response = await _apiClient.get(ApiEndpoints.courseDetails(courseId));
    final data = _data(response.data);
    return CourseModel.fromJson(requiredMap(data['course'], 'course'));
  }

  @override
  Future<RecommendedCoursesResultModel> getRecommendedCourses(int limit) async {
    final response = await _apiClient.get(
      ApiEndpoints.recommendedCourses,
      queryParameters: {'limit': limit},
    );
    return RecommendedCoursesResultModel.fromJson(_data(response.data));
  }

  @override
  Future<CoursesPageModel> getSavedCourses(int page, int limit) async {
    final response = await _apiClient.get(
      ApiEndpoints.savedCourses,
      queryParameters: {'page': page, 'limit': limit},
    );
    return _page(response.data);
  }

  @override
  Future<CoursesPageModel> getEnrollments(int page, int limit) async {
    final response = await _apiClient.get(
      ApiEndpoints.courseEnrollments,
      queryParameters: {'page': page, 'limit': limit},
    );
    return _page(response.data);
  }

  @override
  Future<SavedCourseResultModel> saveCourse(String courseId) async {
    final response = await _apiClient.post(ApiEndpoints.courseSave(courseId));
    return SavedCourseResultModel.fromJson(_data(response.data));
  }

  @override
  Future<SavedCourseResultModel> unsaveCourse(String courseId) async {
    final response = await _apiClient.delete(ApiEndpoints.courseSave(courseId));
    return SavedCourseResultModel.fromJson(_data(response.data));
  }

  @override
  Future<EnrollmentMutationResultModel> enrollCourse(String courseId) async {
    final response = await _apiClient.post(ApiEndpoints.courseEnroll(courseId));
    return EnrollmentMutationResultModel.fromJson(_data(response.data));
  }

  @override
  Future<EnrollmentMutationResultModel> updateEnrollment(
    String courseId, {
    int? progress,
    EnrollmentStatus? status,
  }) async {
    final response = await _apiClient.patch(
      ApiEndpoints.courseEnrollment(courseId),
      data: {
        if (progress != null) 'progress': progress,
        if (status != null) 'status': status.name,
      },
    );
    return EnrollmentMutationResultModel.fromJson(_data(response.data));
  }

  CoursesPageModel _page(Object? body) {
    final envelope = _envelope(body);
    return CoursesPageModel.fromParts(
      data: requiredMap(envelope['data'], 'data'),
      meta: requiredMap(envelope['meta'], 'meta'),
    );
  }

  Map<String, dynamic> _data(Object? body) =>
      requiredMap(_envelope(body)['data'], 'data');

  Map<String, dynamic> _envelope(Object? body) {
    final envelope = requiredMap(body, 'response');
    if (envelope['success'] != true) {
      throw const FormatException('Unexpected unsuccessful response');
    }
    return envelope;
  }
}

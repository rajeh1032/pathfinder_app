import '../../domain/entities/courses_page.dart';
import 'course_model.dart';
import 'course_model_parsing.dart';
import 'pagination_model.dart';

class CoursesPageModel {
  const CoursesPageModel({required this.courses, required this.pagination});

  factory CoursesPageModel.fromParts({
    required Map<String, dynamic> data,
    required Map<String, dynamic> meta,
  }) =>
      CoursesPageModel(
        courses: requiredList(data, 'courses')
            .map((item) => CourseModel.fromJson(requiredMap(item, 'course')))
            .toList(growable: false),
        pagination: PaginationModel.fromJson(
          requiredMap(meta['pagination'], 'pagination'),
        ),
      );

  final List<CourseModel> courses;
  final PaginationModel pagination;

  CoursesPage toEntity() => CoursesPage(
        courses: List.unmodifiable(courses.map((item) => item.toEntity())),
        pagination: pagination.toEntity(),
      );
}

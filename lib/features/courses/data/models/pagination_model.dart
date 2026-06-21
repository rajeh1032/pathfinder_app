import '../../domain/entities/courses_page.dart';
import 'course_model_parsing.dart';

class PaginationModel {
  const PaginationModel({
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    this.nextPage,
    this.previousPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        page: requiredInt(json, 'page', min: 1),
        limit: requiredInt(json, 'limit', min: 1),
        totalItems: requiredInt(json, 'totalItems', min: 0),
        totalPages: requiredInt(json, 'totalPages', min: 0),
        hasNextPage: requiredBool(json, 'hasNextPage'),
        hasPreviousPage: requiredBool(json, 'hasPreviousPage'),
        nextPage: _nullableInt(json['nextPage']),
        previousPage: _nullableInt(json['previousPage']),
      );

  final int page;
  final int limit;
  final int totalItems;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int? nextPage;
  final int? previousPage;

  Pagination toEntity() => Pagination(
        page: page,
        limit: limit,
        totalItems: totalItems,
        totalPages: totalPages,
        hasNextPage: hasNextPage,
        hasPreviousPage: hasPreviousPage,
        nextPage: nextPage,
        previousPage: previousPage,
      );

  static int? _nullableInt(Object? value) {
    if (value == null) return null;
    final parsed = numberValue(value);
    if (parsed == null || parsed % 1 != 0) {
      throw const FormatException('Invalid nullable integer');
    }
    return parsed.toInt();
  }
}

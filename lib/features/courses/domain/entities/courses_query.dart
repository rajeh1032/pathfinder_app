import 'package:equatable/equatable.dart';

enum CourseSort { newest, rating, popular }

class CoursesQuery extends Equatable {
  const CoursesQuery({
    this.page = 1,
    this.limit = 20,
    this.q,
    this.category,
    this.level,
    this.provider,
    this.language,
    this.isFree,
    this.sort = CourseSort.newest,
  });

  final int page;
  final int limit;
  final String? q;
  final String? category;
  final String? level;
  final String? provider;
  final String? language;
  final bool? isFree;
  final CourseSort sort;

  CoursesQuery copyWith({
    int? page,
    String? q,
    bool clearQuery = false,
    String? category,
    bool clearCategory = false,
    String? level,
    bool clearLevel = false,
    String? provider,
    bool clearProvider = false,
    String? language,
    bool clearLanguage = false,
    bool? isFree,
    bool clearIsFree = false,
    CourseSort? sort,
  }) =>
      CoursesQuery(
        page: page ?? this.page,
        limit: limit,
        q: clearQuery ? null : q ?? this.q,
        category: clearCategory ? null : category ?? this.category,
        level: clearLevel ? null : level ?? this.level,
        provider: clearProvider ? null : provider ?? this.provider,
        language: clearLanguage ? null : language ?? this.language,
        isFree: clearIsFree ? null : isFree ?? this.isFree,
        sort: sort ?? this.sort,
      );

  Map<String, dynamic> toQueryParameters() => {
        'page': page,
        'limit': limit,
        if (_value(q) case final value?) 'q': value,
        if (_value(category) case final value?) 'category': value,
        if (_value(level) case final value?) 'level': value,
        if (_value(provider) case final value?) 'provider': value,
        if (_value(language) case final value?) 'language': value,
        if (isFree != null) 'isFree': isFree,
        'sort': sort.name,
      };

  static String? _value(String? value) =>
      value == null || value.trim().isEmpty ? null : value.trim();

  @override
  List<Object?> get props => [
        page,
        limit,
        q,
        category,
        level,
        provider,
        language,
        isFree,
        sort,
      ];
}

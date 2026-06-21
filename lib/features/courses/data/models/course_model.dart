import '../../domain/entities/course.dart';
import 'course_enrollment_model.dart';
import 'course_model_parsing.dart';
import 'course_skill_model.dart';

class CourseModel {
  const CourseModel({
    required this.id,
    required this.title,
    required this.provider,
    required this.learningOutcomes,
    required this.isFree,
    required this.reviewsCount,
    required this.enrollmentCount,
    required this.popularityScore,
    required this.skills,
    required this.isSaved,
    this.description,
    this.url,
    this.thumbnailUrl,
    this.videoUrl,
    this.level,
    this.duration,
    this.category,
    this.language,
    this.price,
    this.currency,
    this.rating,
    this.enrollment,
    this.createdAt,
    this.updatedAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: requiredString(json, 'id'),
        title: requiredString(json, 'title'),
        description: nullableString(json['description']),
        provider: requiredString(json, 'provider'),
        url: nullableString(json['url']),
        thumbnailUrl: nullableString(json['thumbnailUrl']),
        videoUrl: nullableString(json['videoUrl']),
        level: nullableString(json['level']),
        duration: nullableString(json['duration']),
        category: nullableString(json['category']),
        learningOutcomes: stringList(json, 'learningOutcomes'),
        language: nullableString(json['language']),
        price: nullableDouble(json['price']),
        currency: nullableString(json['currency']),
        isFree: requiredBool(json, 'isFree'),
        rating: nullableDouble(json['rating']),
        reviewsCount: requiredInt(json, 'reviewsCount', min: 0),
        enrollmentCount: requiredInt(json, 'enrollmentCount', min: 0),
        popularityScore: requiredInt(json, 'popularityScore', min: 0),
        skills: requiredList(json, 'skills')
            .map((item) => CourseSkillModel.fromJson(
                  requiredMap(item, 'skill'),
                ))
            .toList(growable: false),
        isSaved: requiredBool(json, 'isSaved'),
        enrollment: json['enrollment'] == null
            ? null
            : CourseEnrollmentModel.fromJson(
                requiredMap(json['enrollment'], 'enrollment'),
              ),
        createdAt: nullableDate(json['createdAt']),
        updatedAt: nullableDate(json['updatedAt']),
      );

  final String id;
  final String title;
  final String? description;
  final String provider;
  final String? url;
  final String? thumbnailUrl;
  final String? videoUrl;
  final String? level;
  final String? duration;
  final String? category;
  final List<String> learningOutcomes;
  final String? language;
  final double? price;
  final String? currency;
  final bool isFree;
  final double? rating;
  final int reviewsCount;
  final int enrollmentCount;
  final int popularityScore;
  final List<CourseSkillModel> skills;
  final bool isSaved;
  final CourseEnrollmentModel? enrollment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Course toEntity() => Course(
        id: id,
        title: title,
        description: description,
        provider: provider,
        url: url,
        thumbnailUrl: thumbnailUrl,
        videoUrl: videoUrl,
        level: level,
        duration: duration,
        category: category,
        learningOutcomes: List.unmodifiable(learningOutcomes),
        language: language,
        price: price,
        currency: currency,
        isFree: isFree,
        rating: rating,
        reviewsCount: reviewsCount,
        enrollmentCount: enrollmentCount,
        popularityScore: popularityScore,
        skills: List.unmodifiable(skills.map((item) => item.toEntity())),
        isSaved: isSaved,
        enrollment: enrollment?.toEntity(),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

import 'package:equatable/equatable.dart';

import 'course_enrollment.dart';
import 'course_skill.dart';

class Course extends Equatable {
  const Course({
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
  final List<CourseSkill> skills;
  final bool isSaved;
  final CourseEnrollment? enrollment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Course copyWith({bool? isSaved, CourseEnrollment? enrollment}) => Course(
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
        learningOutcomes: learningOutcomes,
        language: language,
        price: price,
        currency: currency,
        isFree: isFree,
        rating: rating,
        reviewsCount: reviewsCount,
        enrollmentCount: enrollmentCount,
        popularityScore: popularityScore,
        skills: skills,
        isSaved: isSaved ?? this.isSaved,
        enrollment: enrollment ?? this.enrollment,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        provider,
        url,
        thumbnailUrl,
        videoUrl,
        level,
        duration,
        category,
        learningOutcomes,
        language,
        price,
        currency,
        isFree,
        rating,
        reviewsCount,
        enrollmentCount,
        popularityScore,
        skills,
        isSaved,
        enrollment,
        createdAt,
        updatedAt,
      ];
}

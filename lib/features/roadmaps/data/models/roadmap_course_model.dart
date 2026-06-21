import '../../domain/entities/roadmap.dart';
import 'model_parsing.dart';

class RoadmapCourseModel {
  const RoadmapCourseModel({
    required this.id,
    required this.title,
    required this.provider,
    this.url,
    this.thumbnailUrl,
    this.videoUrl,
    this.duration,
    this.level,
  });

  factory RoadmapCourseModel.fromJson(Map<String, dynamic> json) {
    return RoadmapCourseModel(
      id: requiredString(json, 'id'),
      title: requiredString(json, 'title'),
      provider: requiredString(json, 'provider'),
      url: nullableString(json['url']),
      thumbnailUrl: nullableString(json['thumbnailUrl']),
      videoUrl: nullableString(json['videoUrl']),
      duration: nullableString(json['duration']),
      level: nullableString(json['level']),
    );
  }

  final String id;
  final String title;
  final String provider;
  final String? url;
  final String? thumbnailUrl;
  final String? videoUrl;
  final String? duration;
  final String? level;

  RoadmapCourse toEntity() => RoadmapCourse(
        id: id,
        title: title,
        provider: provider,
        url: url,
        thumbnailUrl: thumbnailUrl,
        videoUrl: videoUrl,
        duration: duration,
        level: level,
      );
}

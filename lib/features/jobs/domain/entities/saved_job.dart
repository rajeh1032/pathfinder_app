import 'package:equatable/equatable.dart';

/// A job the user has saved (from `GET /v1/jobs/saved`).
class SavedJob extends Equatable {
  const SavedJob({
    required this.id,
    required this.title,
    this.company,
    this.location,
    this.jobType,
    this.logoUrl,
  });

  final String id;
  final String title;
  final String? company;
  final String? location;
  final String? jobType;
  final String? logoUrl;

  @override
  List<Object?> get props => [id, title, company, location, jobType, logoUrl];
}

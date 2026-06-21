import 'package:pathfinder_app/features/courses/domain/entities/course.dart';
import 'package:pathfinder_app/features/courses/domain/entities/course_enrollment.dart';

const courseJson = <String, dynamic>{
  'id': '60000000-0000-4000-8000-000000000001',
  'title': 'React Fundamentals',
  'description': 'Build modern React applications.',
  'provider': 'MaharaTech',
  'url': 'https://example.com/course',
  'thumbnailUrl': null,
  'videoUrl': null,
  'level': 'Beginner',
  'duration': '8 hours',
  'category': 'Frontend',
  'learningOutcomes': ['Build reusable components'],
  'language': 'English',
  'price': 0,
  'currency': 'EGP',
  'isFree': true,
  'rating': 4.7,
  'reviewsCount': 120,
  'enrollmentCount': 2500,
  'popularityScore': 92,
  'skills': [
    {
      'id': '20000000-0000-4000-8000-000000000001',
      'name': 'React',
      'category': 'Frontend',
      'level': null,
      'confidence': 0.95,
      'source': 'admin_manual',
    }
  ],
  'isSaved': false,
  'enrollment': null,
  'createdAt': '2026-06-20T10:00:00.000Z',
  'updatedAt': '2026-06-20T10:00:00.000Z',
};

const enrollmentJson = <String, dynamic>{
  'id': '70000000-0000-4000-8000-000000000001',
  'status': 'active',
  'progress': 40,
  'enrolledAt': '2026-06-20T10:00:00.000Z',
  'completedAt': null,
  'createdAt': '2026-06-20T10:00:00.000Z',
  'updatedAt': '2026-06-20T12:00:00.000Z',
};

const courseEntity = Course(
  id: '60000000-0000-4000-8000-000000000001',
  title: 'React Fundamentals',
  provider: 'MaharaTech',
  learningOutcomes: [],
  isFree: true,
  reviewsCount: 0,
  enrollmentCount: 0,
  popularityScore: 0,
  skills: [],
  isSaved: false,
);

const enrollmentEntity = CourseEnrollment(
  id: '70000000-0000-4000-8000-000000000001',
  status: EnrollmentStatus.active,
  progress: 40,
);

import 'package:flutter/widgets.dart';

import '../../../../core/app/app_keys.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../domain/entities/app_notification.dart';

/// Resolves the in-app destination for a notification action and navigates
/// to it. Returns `false` when the notification has no actionable target.
class NotificationNavigator {
  const NotificationNavigator._();

  static bool open(BuildContext context, AppNotification notification) {
    final target = _targetFor(notification.type, notification.metadata);
    if (target == null) return false;

    Navigator.pushNamed(
      context,
      target.route,
      arguments: RouteArguments(id: target.id),
    );
    return true;
  }

  /// Navigates from a raw FCM data payload using the global navigator key.
  /// Used when a push notification is tapped from background/terminated state.
  static bool openFromData(Map<String, dynamic> data) {
    final type = data['type']?.toString();
    if (type == null) return false;

    final target = _targetFor(type, data);
    final navigator = appNavigatorKey.currentState;
    if (target == null || navigator == null) return false;

    navigator.pushNamed(
      target.route,
      arguments: RouteArguments(id: target.id),
    );
    return true;
  }

  static _NotificationTarget? _targetFor(
    String type,
    Map<String, dynamic> data,
  ) {
    return switch (type) {
      'job_match' => _build(AppRoutes.jobDetails, data, 'job_id'),
      'roadmap_ready' => _build(AppRoutes.roadmapDetails, data, 'roadmap_id'),
      'interview_result' =>
        _build(AppRoutes.interviewResult, data, 'interview_session_id'),
      'cv_ready' => _build(AppRoutes.cvAnalysisResult, data, 'cv_id'),
      'course_completed' => _build(AppRoutes.courseDetails, data, 'course_id'),
      _ => null,
    };
  }

  static _NotificationTarget? _build(
    String route,
    Map<String, dynamic> data,
    String idKey,
  ) {
    final id = _stringValue(data[idKey]);
    if (id == null) return null;
    return _NotificationTarget(route: route, id: id);
  }

  static String? _stringValue(Object? value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }
}

class _NotificationTarget {
  const _NotificationTarget({required this.route, required this.id});

  final String route;
  final String id;
}

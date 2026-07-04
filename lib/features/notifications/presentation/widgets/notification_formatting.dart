import 'package:easy_localization/easy_localization.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/app_notification.dart';

/// Presentation helpers that turn raw notification data into localized,
/// display-ready strings. Kept out of widgets to avoid logic in the UI.
class NotificationFormatting {
  const NotificationFormatting._();

  static String categoryLabelKey(NotificationCategory category) {
    return switch (category) {
      NotificationCategory.job => 'notifications.labelJob',
      NotificationCategory.interview => 'notifications.labelInterview',
      NotificationCategory.insight => 'notifications.labelInsight',
      NotificationCategory.learning => 'notifications.labelLearning',
      NotificationCategory.document => 'notifications.labelDocument',
      NotificationCategory.other => 'notifications.labelGeneral',
    };
  }

  static String relativeTime(DateTime createdAt) {
    final now = DateTime.now();
    final diff = now.difference(createdAt);

    if (diff.inSeconds < 60) {
      return 'notifications.timeJustNow'.tr();
    }
    if (diff.inMinutes < 60) {
      return 'notifications.timeMinutesAgo'.tr(
        namedArgs: {'count': '${diff.inMinutes}'},
      );
    }
    if (diff.inHours < 24) {
      return 'notifications.timeHoursAgo'.tr(
        namedArgs: {'count': '${diff.inHours}'},
      );
    }
    if (diff.inDays < 7) {
      return 'notifications.timeDaysAgo'.tr(
        namedArgs: {'count': '${diff.inDays}'},
      );
    }
    return DateFormatter.format(createdAt);
  }

  static String progressLabel(double progress) {
    final percent = (progress.clamp(0.0, 1.0) * 100).round();
    return 'notifications.progressComplete'.tr(
      namedArgs: {'percent': '$percent'},
    );
  }
}

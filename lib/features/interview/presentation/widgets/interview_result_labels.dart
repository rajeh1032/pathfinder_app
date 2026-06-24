import 'package:easy_localization/easy_localization.dart';

/// Maps backend interview/question enum values to localized labels.
///
/// Dynamic AI content (feedback, suggestions, skill names) is rendered as-is,
/// while these fixed enum values are mapped to Easy Localization keys so the
/// result screen stays fully localized for both English and Arabic.
class InterviewResultLabels {
  const InterviewResultLabels._();

  static String roundLabel(String interviewType) {
    switch (interviewType) {
      case 'behavioral':
        return 'interview.behavioralRound'.tr();
      case 'mock_hr':
        return 'interview.hrRound'.tr();
      case 'technical':
        return 'interview.technicalRound'.tr();
      default:
        return interviewType.isEmpty
            ? 'interview.technicalRound'.tr()
            : interviewType.toUpperCase();
    }
  }

  static String questionStatusLabel(String status) {
    switch (status) {
      case 'passed':
        return 'interview.statusPassed'.tr();
      case 'needs_improvement':
        return 'interview.needsImprovement'.tr();
      case 'skipped':
        return 'interview.statusSkipped'.tr();
      default:
        return 'interview.statusUnanswered'.tr();
    }
  }

  static String interviewTypeLabel(String interviewType) {
    switch (interviewType) {
      case 'behavioral':
        return 'interview.behavioralInterview'.tr();
      case 'mock_hr':
        return 'interview.mockHrInterview'.tr();
      case 'technical':
        return 'interview.technicalInterview'.tr();
      default:
        return interviewType.isEmpty
            ? 'interview.technicalInterview'.tr()
            : interviewType;
    }
  }

  /// Short format name (without the word "Interview"), e.g. `Technical`.
  static String interviewFormatLabel(String interviewType) {
    switch (interviewType) {
      case 'behavioral':
        return 'interview.behavioral'.tr();
      case 'mock_hr':
        return 'interview.mockHr'.tr();
      case 'technical':
        return 'interview.technical'.tr();
      default:
        return interviewType.isEmpty ? 'interview.technical'.tr() : interviewType;
    }
  }

  /// Session lifecycle status label used in the history list.
  static String sessionStatusLabel(String status) {
    switch (status) {
      case 'completed':
        return 'interview.statusCompleted'.tr();
      case 'cancelled':
        return 'interview.statusCancelled'.tr();
      case 'in_progress':
        return 'interview.statusInProgress'.tr();
      case 'started':
        return 'interview.statusStarted'.tr();
      default:
        return status.isEmpty ? 'interview.statusStarted'.tr() : status;
    }
  }
}

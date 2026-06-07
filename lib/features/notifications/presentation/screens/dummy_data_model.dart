enum NotificationType { jobMatch, upcoming, aiInsight, learningProgress }

enum NotificationTab { all, jobs, learning }

class NotificationModel {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final String time;
  final String? actionLabel;
  final double? progress; // for learningProgress type
  final NotificationTab tab;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    required this.tab,
    this.actionLabel,
    this.progress,
  });
}

class NotificationDummyData {
  static const List<NotificationModel> all = [
    NotificationModel(
      id: '1',
      type: NotificationType.jobMatch,
      title: 'New High Match!',
      body: 'Senior Frontend role at Stripe (94% Match). Based on your expertise in Tailwind CSS and React.',
      time: '2m ago',
      actionLabel: 'View Job',
      tab: NotificationTab.jobs,
    ),
    NotificationModel(
      id: '2',
      type: NotificationType.upcoming,
      title: 'Mock Interview starting in 30 minutes. Get ready!',
      body: 'Focus: System Design and Core Architecture.',
      time: '50m left',
      tab: NotificationTab.all,
    ),
    NotificationModel(
      id: '3',
      type: NotificationType.aiInsight,
      title: 'AI Career Insight',
      body: 'Users with your profile are seeing a 15% salary bump after learning Next.js.',
      time: '1h ago',
      actionLabel: 'Analyze Skill Path →',
      tab: NotificationTab.all,
    ),
    NotificationModel(
      id: '4',
      type: NotificationType.learningProgress,
      title: 'Learning Progress',
      body: "Don't lose your momentum! You're 2 steps away from completing the React Mastery path.",
      time: '2h ago',
      progress: 0.88,
      tab: NotificationTab.learning,
    ),
  ];

  static List<NotificationModel> filtered(NotificationTab tab) {
    if (tab == NotificationTab.all) return all;
    return all.where((n) => n.tab == tab).toList();
  }
}
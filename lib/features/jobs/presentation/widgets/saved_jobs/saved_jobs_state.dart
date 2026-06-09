import 'package:flutter/foundation.dart';

class SavedJobsState {
  const SavedJobsState._();

  static const primaryJobId = 'senior-ux-designer';
  static const architectJobId = 'senior-frontend-architect';

  static final ValueNotifier<Set<String>> savedIds =
      ValueNotifier<Set<String>>({
    primaryJobId,
    architectJobId,
  });

  static void toggle(String id) {
    final next = Set<String>.of(savedIds.value);
    next.contains(id) ? next.remove(id) : next.add(id);
    savedIds.value = next;
  }

  static void remove(String id) {
    final next = Set<String>.of(savedIds.value)..remove(id);
    savedIds.value = next;
  }
}

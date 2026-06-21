import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';
import '../../domain/entities/course_enrollment.dart';

class EnrollmentEditor extends StatelessWidget {
  const EnrollmentEditor({
    required this.progress,
    required this.status,
    required this.isDirty,
    required this.isLoading,
    required this.onProgress,
    required this.onStatus,
    required this.onUpdate,
    super.key,
  });

  final int progress;
  final EnrollmentStatus status;
  final bool isDirty;
  final bool isLoading;
  final ValueChanged<int> onProgress;
  final ValueChanged<EnrollmentStatus> onStatus;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('courses.enrollment.title'.tr(),
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.md),
              Text('courses.progressValue'.tr(args: ['$progress'])),
              Slider(
                value: progress.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                label: '$progress%',
                onChanged:
                    isLoading ? null : (value) => onProgress(value.round()),
              ),
              DropdownButtonFormField<EnrollmentStatus>(
                initialValue: status,
                decoration: InputDecoration(
                  labelText: 'courses.enrollment.status'.tr(),
                ),
                items: EnrollmentStatus.values
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                              'courses.enrollment.statuses.${value.name}'.tr()),
                        ))
                    .toList(growable: false),
                onChanged: isLoading
                    ? null
                    : (value) {
                        if (value != null) onStatus(value);
                      },
              ),
              const SizedBox(height: AppSpacing.lg),
              CustomButton(
                labelKey: 'courses.enrollment.update',
                isLoading: isLoading,
                onPressed: isDirty && !isLoading ? onUpdate : null,
              ),
            ],
          ),
        ),
      );
}

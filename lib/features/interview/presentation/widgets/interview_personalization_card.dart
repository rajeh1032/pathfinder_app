import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'interview_personalization_bullet_item.dart';
import 'interview_result_labels.dart';

class InterviewPersonalizationCard extends StatefulWidget {
  const InterviewPersonalizationCard({
    required this.colorScheme,
    required this.interviewType,
    this.careerPathName,
    super.key,
  });

  final ColorScheme colorScheme;
  final String interviewType;
  final String? careerPathName;

  @override
  State<InterviewPersonalizationCard> createState() =>
      _InterviewPersonalizationCardState();
}

class _InterviewPersonalizationCardState
    extends State<InterviewPersonalizationCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = widget.colorScheme;
    final role = (widget.careerPathName != null &&
            widget.careerPathName!.trim().isNotEmpty)
        ? widget.careerPathName!.trim()
        : 'interview.yourTargetRole'.tr();
    final format = InterviewResultLabels.interviewFormatLabel(
      widget.interviewType,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg.w),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: _AnimatedPersonalizationIcon(
              controller: _controller,
              colorScheme: colorScheme,
            ),
          ),
          SizedBox(height: AppSpacing.md.h),
          Text(
            'interview.aiPersonalizationActive'.tr(),
            style: AppTextStyles.titleLarge(colorScheme.primary),
          ),
          SizedBox(height: AppSpacing.sm.h),
          Text(
            'interview.aiPersonalizationDescriptionDynamic'
                .tr(namedArgs: {'role': role}),
            style: AppTextStyles.bodyMedium(colorScheme.onSurfaceVariant)
                .copyWith(height: 1.55),
          ),
          SizedBox(height: AppSpacing.sm.h),
          InterviewPersonalizationBulletItem(
            'interview.personalizationBulletRole',
            namedArgs: {'role': role},
          ),
          InterviewPersonalizationBulletItem(
            'interview.personalizationBulletFormat',
            namedArgs: {'format': format},
          ),
          const InterviewPersonalizationBulletItem(
            'interview.personalizationBulletCv',
          ),
        ],
      ),
    );
  }
}

class _AnimatedPersonalizationIcon extends StatelessWidget {
  const _AnimatedPersonalizationIcon({
    required this.controller,
    required this.colorScheme,
  });

  final AnimationController controller;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pulse = 0.92 + (controller.value * 0.16);
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary
                    .withValues(alpha: 0.25 * controller.value),
                blurRadius: 18 * controller.value,
                spreadRadius: 2 * controller.value,
              ),
            ],
          ),
          child: Transform.scale(scale: pulse, child: child),
        );
      },
      child: CircleAvatar(
        radius: 28.r,
        backgroundColor: colorScheme.primary,
        child: Icon(
          Icons.psychology_alt_rounded,
          color: colorScheme.onPrimary,
          size: 28.sp,
        ),
      ),
    );
  }
}

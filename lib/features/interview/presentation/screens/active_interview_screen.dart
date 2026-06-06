import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/routing/app_routes.dart';

class ActiveInterviewScreen extends StatelessWidget {
  const ActiveInterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('routes.activeInterview'.tr()),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = constraints.maxWidth > 620 ? 620.0 : constraints.maxWidth;

            return ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md.w,
                AppSpacing.sm.h,
                AppSpacing.md.w,
                AppSpacing.lg.h + bottomInset + AppSpacing.md.h,
              ),
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _ProgressHeader(colorScheme: colorScheme),
                        SizedBox(height: AppSpacing.lg.h),
                        _AvatarBadge(colorScheme: colorScheme),
                        SizedBox(height: AppSpacing.lg.h),
                        _QuestionCard(colorScheme: colorScheme),
                        SizedBox(height: AppSpacing.lg.h),
                        _AnswerCard(colorScheme: colorScheme),
                        SizedBox(height: AppSpacing.xxl.h),
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            label: 'interview.submitAnswer'.tr(),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.interviewResult);
                            },
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        TextButton(
                          onPressed: () {},
                          child: Text('interview.skipQuestion'.tr()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'interview.questionProgress'.tr(
                namedArgs: {'current': '3', 'total': '10'},
              ),
              style: AppTextStyles.labelLarge(
                colorScheme.onSurfaceVariant,
              ).copyWith(letterSpacing: 1.2),
            ),
            Text(
              'interview.completeProgress'.tr(namedArgs: {'value': '30'}),
              style: AppTextStyles.labelLarge(colorScheme.primary),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            minHeight: 10.h,
            value: 0.3,
            backgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.35),
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ),
      ],
    );
  }
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 118.w,
          height: 118.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: colorScheme.primaryContainer, width: 6.w),
          ),
        ),
        CircleAvatar(
          radius: 44.w,
          backgroundColor: colorScheme.primaryContainer,
          backgroundImage: const AssetImage(AppAssets.aiMentorAvatar),
        ),
        Positioned(
          right: 12.w,
          bottom: 16.h,
          child: Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.surface, width: 2.w),
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              color: colorScheme.onSecondary,
              size: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 24.r,
            offset: Offset(0, 12.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'interview.activeQuestion'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.titleLarge(colorScheme.onSurface).copyWith(
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerCard extends StatelessWidget {
  const _AnswerCard({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 130.h,
            child: TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'interview.answerHint'.tr(),
                hintMaxLines: 2,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTextStyles.bodyLarge(colorScheme.onSurface),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              child: Icon(Icons.mic_rounded, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}

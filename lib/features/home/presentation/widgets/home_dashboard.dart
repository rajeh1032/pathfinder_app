// lib/features/home/presentation/widgets/home_header.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entites/home_entity.dart';

class HomeHeader extends StatelessWidget {
  final HomeUserEntity user;
  final int cvScore;

  const HomeHeader({super.key, required this.user, required this.cvScore});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final name = user.name.trim().split(RegExp(r'\s+')).firstOrNull ?? '';
    final wave = String.fromCharCode(0x1F44B);
    final greeting = name.isEmpty
        ? '${'home.hello'.tr()} $wave'
        : '${'home.hello'.tr()}, $name $wave';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting, style: theme.textTheme.headlineMedium),
              SizedBox(height: 4.h),
              Text(
                'home.readyToLevelUp'.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        _CvScoreCircle(score: cvScore),
      ],
    );
  }
}

class _CvScoreCircle extends StatelessWidget {
  final int score;

  const _CvScoreCircle({required this.score});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [colors.primary, colors.secondary, colors.primary],
          stops: const [0.0, 0.75, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(2.5.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Center(
          child: Text(
            '$score',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              color: colors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

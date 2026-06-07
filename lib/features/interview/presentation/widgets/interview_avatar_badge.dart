import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';

class InterviewAvatarBadge extends StatelessWidget {
  const InterviewAvatarBadge({required this.colorScheme, super.key});

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

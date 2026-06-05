import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_styles.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: colorScheme.primary.withAlpha(26),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.alt_route_rounded,
            color: colorScheme.primary,
            size: 18.sp,
          ),
        ),
        SizedBox(width: 8.w),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'PathFinder ',
                style: AppTextStyles.titleLarge(colorScheme.primary),
              ),
              TextSpan(
                text: 'AI',
                style: AppTextStyles.titleLarge(colorScheme.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

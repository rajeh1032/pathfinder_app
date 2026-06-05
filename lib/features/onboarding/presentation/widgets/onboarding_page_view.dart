import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'onboarding_page_data.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingPageData data;

  const OnboardingPageView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Illustration area
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Image.asset(
                data.illustrationAsset,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => _PlaceholderIllustration(
                  index: OnboardingPageData.pages.indexOf(data),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 32.h),

        // Text content
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineLarge(colorScheme.onSurface),
              ),
              SizedBox(height: 16.h),
              Text(
                data.description,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Shown when illustration asset is not found (e.g. during development)
class _PlaceholderIllustration extends StatelessWidget {
  final int index;

  const _PlaceholderIllustration({required this.index});

  static const _icons = [
    Icons.psychology_alt_rounded,
    Icons.work_outline_rounded,
    Icons.trending_up_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Center(
        child: Icon(
          _icons[index % _icons.length],
          size: 100.sp,
          color: colorScheme.primary.withAlpha(102),
        ),
      ),
    );
  }
}

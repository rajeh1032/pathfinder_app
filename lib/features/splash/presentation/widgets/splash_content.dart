import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';
import 'concentric_circles.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    super.key,
    required this.logoScale,
    required this.logoOpacity,
    required this.textOpacity,
    required this.progressValue,
  });

  final Animation<double> logoScale;
  final Animation<double> logoOpacity;
  final Animation<double> textOpacity;
  final Animation<double> progressValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        const ConcentricCircles(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: logoScale,
                builder: (_, __) => Opacity(
                  opacity: logoOpacity.value,
                  child: Transform.scale(
                    scale: logoScale.value,
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withAlpha(38),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.alt_route_rounded,
                          color: colorScheme.primary,
                          size: 40.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              AnimatedBuilder(
                animation: textOpacity,
                builder: (_, __) => Opacity(
                  opacity: textOpacity.value,
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'PathFinder ',
                              style: AppTextStyles.displayMedium(
                                colorScheme.primary,
                              ),
                            ),
                            TextSpan(
                              text: 'AI',
                              style: AppTextStyles.displayMedium(
                                colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'splash.welcome'.tr(),
                        style: AppTextStyles.bodyMedium(
                          colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 48.h,
          left: 32.w,
          right: 32.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'splash.tagline'.tr(),
                style: TextStyle(
                  fontSize: 10.sp,
                  letterSpacing: 2,
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 3.h,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withAlpha(38),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AnimatedBuilder(
                  animation: progressValue,
                  builder: (_, __) => FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressValue.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withAlpha(38),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.alt_route_rounded,
                          color: AppColors.primary,
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
                                AppColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: 'AI',
                              style: AppTextStyles.displayMedium(
                                AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Guided Intelligence for Careers',
                        style: AppTextStyles.bodyMedium(
                          AppColors.neutral,
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
                'INITIALISING JOURNEY',
                style: TextStyle(
                  fontSize: 10.sp,
                  letterSpacing: 2,
                  color: AppColors.neutral,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 3.h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(38),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AnimatedBuilder(
                  animation: progressValue,
                  builder: (_, __) => FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressValue.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
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

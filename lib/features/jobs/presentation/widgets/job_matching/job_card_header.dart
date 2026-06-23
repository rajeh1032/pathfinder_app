import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobCardHeader extends StatelessWidget {
  const JobCardHeader({
    super.key,
    required this.title,
    required this.companyLocation,
    this.imageUrl,
  });

  final String title;
  final String companyLocation;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CompanyImage(imageUrl: imageUrl),
        SizedBox(width: AppSpacing.md.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              SizedBox(height: 2.h),
              Text(
                companyLocation,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CompanyImage extends StatelessWidget {
  const _CompanyImage({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Container(
      width: 58.w,
      height: 58.h,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasImage
          ? Image.network(
              imageUrl!,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => _FallbackCompanyIcon(colors),
            )
          : _FallbackCompanyIcon(colors),
    );
  }
}

class _FallbackCompanyIcon extends StatelessWidget {
  const _FallbackCompanyIcon(this.colors);

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.inverseSurface,
              colors.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppRadius.sm.r),
        ),
        child: Icon(
          Icons.design_services_outlined,
          color: colors.secondaryContainer,
          size: 20.sp,
        ),
      ),
    );
  }
}

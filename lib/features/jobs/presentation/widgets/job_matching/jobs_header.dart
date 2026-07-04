import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theme/app_spacing.dart';

class JobsHeader extends StatelessWidget {
  const JobsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md.w,
        AppSpacing.md.h,
        AppSpacing.md.w,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'app.name'.tr(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: .22),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: Ink(
                width: 54.w,
                height: 54.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.notifications),
                  icon: Icon(
                    Icons.notifications,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withValues(alpha: .58),
                    size: 25.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

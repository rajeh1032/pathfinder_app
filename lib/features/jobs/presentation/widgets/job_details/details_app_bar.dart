import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../saved_jobs/saved_jobs_state.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary),
          ),
          Expanded(
            child: Text(
              'jobs.details.title'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('common.actionReady'.tr())),
              );
            },
            icon: Icon(Icons.share_outlined,
                color: Theme.of(context).colorScheme.primary),
          ),
          IconButton(
            onPressed: () => SavedJobsState.toggle(
              SavedJobsState.primaryJobId,
            ),
            icon: ValueListenableBuilder<Set<String>>(
              valueListenable: SavedJobsState.savedIds,
              builder: (context, savedIds, _) {
                final isSaved = savedIds.contains(SavedJobsState.primaryJobId);

                return Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: Theme.of(context).colorScheme.primary,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

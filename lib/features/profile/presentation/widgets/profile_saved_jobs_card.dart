import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/profile.dart';
import 'profile_saved_job_tile.dart';
import 'profile_section_card.dart';

class ProfileSavedJobsCard extends StatelessWidget {
  const ProfileSavedJobsCard({
    required this.jobs,
    required this.savedJobIds,
    required this.onToggleSaved,
    super.key,
  });

  final List<ProfileSavedJob> jobs;
  final Set<String> savedJobIds;
  final ValueChanged<String> onToggleSaved;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      icon: Icons.bookmark_border,
      titleKey: 'profile.savedJobs',
      trailing: TextButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.savedJobs),
        child: Text(context.tr('profile.viewAll')),
      ),
      children: [
        Column(
          children: [
            for (var index = 0; index < jobs.length; index++) ...[
              ProfileSavedJobTile(
                job: jobs[index],
                accentSeed: index,
                isSaved: savedJobIds.contains(jobs[index].id),
                onToggleSaved: onToggleSaved,
              ),
              if (index != jobs.length - 1)
                const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import 'section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailsSection(
      title: 'jobs.details.aboutTitle'.tr(),
      child: Text(
        'jobs.details.aboutBody'.tr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.neutral700,
              height: 1.65,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

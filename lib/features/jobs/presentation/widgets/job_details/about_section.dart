import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return DetailsSection(
      title: 'jobs.details.aboutTitle'.tr(),
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.65,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

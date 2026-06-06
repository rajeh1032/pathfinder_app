import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InterviewPersonalizationCard extends StatelessWidget {
  const InterviewPersonalizationCard({required this.colorScheme, super.key});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.primary,
              child: Icon(
                Icons.psychology_alt_rounded,
                color: colorScheme.onPrimary,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'interview.aiPersonalizationActive'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'interview.aiPersonalizationDescription'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.55,
                ),
          ),
          const SizedBox(height: 10),
          const _BulletItem('interview.personalizationBulletOne'),
          const _BulletItem('interview.personalizationBulletTwo'),
          const _BulletItem('interview.personalizationBulletThree'),
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem(this.titleKey);

  final String titleKey;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 6, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              titleKey.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

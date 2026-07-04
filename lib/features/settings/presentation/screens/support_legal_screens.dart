import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsArticleScreen(
      titleKey: 'settings.helpCenter',
      introKey: 'settings.helpCenterIntro',
      icon: Icons.help_outline,
      sections: [
        _ArticleSection(
          titleKey: 'settings.helpAccountTitle',
          bodyKey: 'settings.helpAccountBody',
        ),
        _ArticleSection(
          titleKey: 'settings.helpNotificationsTitle',
          bodyKey: 'settings.helpNotificationsBody',
        ),
        _ArticleSection(
          titleKey: 'settings.helpContactTitle',
          bodyKey: 'settings.helpContactBody',
        ),
      ],
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsArticleScreen(
      titleKey: 'settings.privacyPolicy',
      introKey: 'settings.privacyPolicyIntro',
      icon: Icons.privacy_tip_outlined,
      sections: [
        _ArticleSection(
          titleKey: 'settings.privacyDataTitle',
          bodyKey: 'settings.privacyDataBody',
        ),
        _ArticleSection(
          titleKey: 'settings.privacyAiTitle',
          bodyKey: 'settings.privacyAiBody',
        ),
        _ArticleSection(
          titleKey: 'settings.privacyControlTitle',
          bodyKey: 'settings.privacyControlBody',
        ),
      ],
    );
  }
}

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsArticleScreen(
      titleKey: 'settings.termsOfService',
      introKey: 'settings.termsIntro',
      icon: Icons.description_outlined,
      sections: [
        _ArticleSection(
          titleKey: 'settings.termsUseTitle',
          bodyKey: 'settings.termsUseBody',
        ),
        _ArticleSection(
          titleKey: 'settings.termsContentTitle',
          bodyKey: 'settings.termsContentBody',
        ),
        _ArticleSection(
          titleKey: 'settings.termsAccountTitle',
          bodyKey: 'settings.termsAccountBody',
        ),
      ],
    );
  }
}

class _SettingsArticleScreen extends StatelessWidget {
  const _SettingsArticleScreen({
    required this.titleKey,
    required this.introKey,
    required this.icon,
    required this.sections,
  });

  final String titleKey;
  final String introKey;
  final IconData icon;
  final List<_ArticleSection> sections;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text(context.tr(titleKey)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.primaryContainer.withValues(alpha: .45),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, size: 34, color: colors.primary),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      context.tr(titleKey),
                      style: AppTextStyles.headlineSmall(colors.onSurface),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      context.tr(introKey),
                      style: AppTextStyles.bodyMedium(
                        colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ...sections.map((section) => _ArticleSectionCard(section)),
          ],
        ),
      ),
    );
  }
}

class _ArticleSectionCard extends StatelessWidget {
  const _ArticleSectionCard(this.section);

  final _ArticleSection section;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: colors.outlineVariant.withValues(alpha: .75),
          ),
          boxShadow: AppShadows.card,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr(section.titleKey),
                style: AppTextStyles.titleSmall(colors.onSurface),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                context.tr(section.bodyKey),
                style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticleSection {
  const _ArticleSection({
    required this.titleKey,
    required this.bodyKey,
  });

  final String titleKey;
  final String bodyKey;
}

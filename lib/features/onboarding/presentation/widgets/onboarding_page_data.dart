import 'package:pathfinder_app/core/constants/app_assets.dart';

class OnboardingPageData {
  final String titleKey;
  final String descriptionKey;
  final String illustrationAsset;

  const OnboardingPageData({
    required this.titleKey,
    required this.descriptionKey,
    required this.illustrationAsset,
  });

  static const List<OnboardingPageData> pages = [
    OnboardingPageData(
      titleKey: 'onboarding.step1Title',
      descriptionKey: 'onboarding.step1Desc',
      illustrationAsset: AppAssets.onboarding1,
    ),
    OnboardingPageData(
      titleKey: 'onboarding.step2Title',
      descriptionKey: 'onboarding.step2Desc',
      illustrationAsset: AppAssets.onboarding2,
    ),
    OnboardingPageData(
      titleKey: 'onboarding.step3Title',
      descriptionKey: 'onboarding.step3Desc',
      illustrationAsset: AppAssets.onboarding3,
    ),
  ];
}

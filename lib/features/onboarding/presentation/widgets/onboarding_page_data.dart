import 'package:easy_localization/easy_localization.dart';
import 'package:pathfinder_app/core/constants/app_assets.dart';

class OnboardingPageData {
  final String title;
  final String description;
  final String illustrationAsset;

  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.illustrationAsset,
  });

  static  List<OnboardingPageData> pages = [
    OnboardingPageData(
      title: 'onboarding.step1Title'.tr(),
      description:
          'onboarding.step1Desc'.tr(),
      illustrationAsset: AppAssets.onboarding1,
    ),
    OnboardingPageData(
      title: 'onboarding.step2Title'.tr(),
      description:
          'onboarding.step2Desc'.tr(),
      illustrationAsset: AppAssets.onboarding2,
    ),
    OnboardingPageData(
      title: 'onboarding.step3Title'.tr(),
      description:
          'onboarding.step3Desc'.tr(),
      illustrationAsset: AppAssets.onboarding3,
    ),
  ];
}
class OnboardingPageData {
  final String title;
  final String description;
  final String illustrationAsset;

  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.illustrationAsset,
  });

  static const List<OnboardingPageData> pages = [
    OnboardingPageData(
      title: 'Your AI Career Guide',
      description:
          'Navigate your future with precision. Get personalized roadmaps tailored to your unique goals.',
      illustrationAsset: 'assets/images/onboarding_1.png',
    ),
    OnboardingPageData(
      title: 'Find Your Dream Job',
      description:
          'Discover thousands of opportunities matched to your skills. Let AI connect you with the perfect role.',
      illustrationAsset: 'assets/images/onboarding_2.png',
    ),
    OnboardingPageData(
      title: 'Learn & Grow Faster',
      description:
          'Follow personalized roadmaps built for your career path. Master the skills that matter most.',
      illustrationAsset: 'assets/images/onboarding_3.png',
    ),
  ];
}
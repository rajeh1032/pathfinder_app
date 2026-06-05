import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/storage/cache_keys.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../cubit/onboarding_cubit.dart';
import '../widgets/onboarding_dot_indicator.dart';
import '../widgets/onboarding_page_data.dart';
import '../widgets/onboarding_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _markOnboardingSeen() async {
    await LocalStorage.setBool(CacheKeys.onboardingSeen, true);
  }

  Future<void> _skip(BuildContext context) async {
    final navigator = Navigator.of(context);
    await _markOnboardingSeen();
    if (!mounted) return;

    navigator.pushReplacementNamed(AppRoutes.login);
  }

  Future<void> _getStarted(BuildContext context) async {
    final navigator = Navigator.of(context);
    await _markOnboardingSeen();
    if (!mounted) return;

    navigator.pushReplacementNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          _animateToPage(state.currentPage);
        },
        builder: (context, state) {
          final cubit = context.read<OnboardingCubit>();
          final isFirst = cubit.isFirstPage;
          final isLast = cubit.isLastPage;

          final colorScheme = Theme.of(context).colorScheme;

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  // Top bar: Skip
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedOpacity(
                        opacity: isLast ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: TextButton(
                          onPressed: isLast ? null : () => _skip(context),
                          child: Text(
                            'onboarding.skip'.tr(),
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurfaceVariant,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Pages
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: cubit.goToPage,
                      itemCount: OnboardingPageData.pages.length,
                      itemBuilder: (_, i) => OnboardingPageView(
                        data: OnboardingPageData.pages[i],
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Dot indicators
                  OnboardingDotIndicator(
                    count: OnboardingPageData.pages.length,
                    currentIndex: state.currentPage,
                  ),

                  SizedBox(height: 32.h),

                  // Action buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        if (!isFirst)
                          TextButton(
                            onPressed: cubit.previousPage,
                            child: Text(
                              'onboarding.back'.tr(),
                              style: AppTextStyles.bodyMedium(
                                colorScheme.primary,
                              ),
                            ),
                          ),
                        if (!isFirst) const Spacer(),
                        Expanded(
                          child: AppButton(
                            label: isLast
                                ? 'onboarding.getStarted'.tr()
                                : 'onboarding.next'.tr(),
                            onPressed: isLast
                                ? () => _getStarted(context)
                                : cubit.nextPage,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

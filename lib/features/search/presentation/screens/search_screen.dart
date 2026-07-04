import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../dummy_data_model.dart';
import '../widgets/recent_search.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_tabs.dart';
import '../widgets/section_title.dart';
import '../widgets/suggestion_card.dart';
import 'package:easy_localization/easy_localization.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchTab _selectedTab = SearchTab.all;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PathFinder AI',
          style: AppTextStyles.titleMedium(AppColors.primary).copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md.w,
              vertical: AppSpacing.sm.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarWidget(controller: _controller),
                SizedBox(height: AppSpacing.md.h),
                // Tabs
                SearchTabs(
                  selected: _selectedTab,
                  onChanged: (tab) => setState(() => _selectedTab = tab),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.md.h),
                  // Recent Searches
                  SectionTitle(title: 'search.recentSearches'.tr()),
                  SizedBox(height: AppSpacing.sm.h),
                  ...SearchDummyData.recentSearches.map(
                    (r) => RecentSearchItem(item: r),
                  ),
                  SizedBox(height: AppSpacing.lg.h),
                  // Suggested For You
                  SectionTitle(title: 'search.suggestedForYou'.tr()),
                  SizedBox(height: AppSpacing.sm.h),
                  ...SearchDummyData.suggestions.map(
                    (s) => SuggestionCard(item: s),
                  ),
                  SizedBox(height: AppSpacing.lg.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

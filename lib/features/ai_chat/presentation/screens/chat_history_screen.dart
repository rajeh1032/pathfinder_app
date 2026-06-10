import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../dummy_session.dart';
import '../model_chat_ai_history.dart';
import '../widgets/empty_state.dart';
import '../widgets/session_card.dart';

class ChatSessionsScreen extends StatefulWidget {
  const ChatSessionsScreen({super.key});

  @override
  State<ChatSessionsScreen> createState() => _ChatSessionsScreenState();
}

class _ChatSessionsScreenState extends State<ChatSessionsScreen> {
  final _searchController = TextEditingController();
  List<ChatSessionModel> _filtered = dummySessions;

  void _onSearch(String query) {
    setState(() {
      _filtered = query.isEmpty
          ? dummySessions
          : dummySessions
          .where((s) =>
      s.title.toLowerCase().contains(query.toLowerCase()) ||
          s.preview.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: cs.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'chatHistory.title'.tr(),
          style: AppTextStyles.titleMedium(AppColors.primary).copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: EdgeInsets.only(right: AppSpacing.md.w),
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.add_rounded, size: 20.sp, color: Colors.white),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.aiChat),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md.w,
              vertical: AppSpacing.sm.h,
            ),
            child: SearchBar(
              controller: _searchController,
              onChanged: _onSearch,
            ),
          ),

          //  Sessions List
          Expanded(
            child: _filtered.isEmpty
                ? EmptyState()
                : ListView.builder(
              padding: EdgeInsets.only(
                top: AppSpacing.xs.h,
                bottom: AppSpacing.xl.h,
              ),
              itemCount: _filtered.length,
              itemBuilder: (_, i) => SessionCard(
                session: _filtered[i],
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.aiChat),
              ),
            ),
          ),

          // View Archived Sessions
          Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.lg.h),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'chatHistory.viewArchived'.tr(),
                    style: AppTextStyles.bodySmall(
                      cs.onSurface.withOpacity(0.5),
                    ).copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.archive_outlined,
                    size: 14.sp,
                    color: cs.onSurface.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}





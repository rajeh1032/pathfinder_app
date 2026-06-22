// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/routing/app_routes.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';
// import '../dummy_session.dart';
// import '../model_chat_ai_history.dart';
// import '../widgets/empty_state.dart';
// import '../widgets/session_card.dart';
//
// class ChatSessionsScreen extends StatefulWidget {
//   const ChatSessionsScreen({super.key});
//
//   @override
//   State<ChatSessionsScreen> createState() => _ChatSessionsScreenState();
// }
//
// class _ChatSessionsScreenState extends State<ChatSessionsScreen> {
//   final _searchController = TextEditingController();
//   List<ChatSessionModel> _filtered = dummySessions;
//
//   void _onSearch(String query) {
//     setState(() {
//       _filtered = query.isEmpty
//           ? dummySessions
//           : dummySessions
//           .where((s) =>
//       s.title.toLowerCase().contains(query.toLowerCase()) ||
//           s.preview.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//
//     return Scaffold(
//       backgroundColor: cs.surface,
//       appBar: AppBar(
//         backgroundColor: cs.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             size: 18.sp,
//             color: cs.onSurface,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'chatHistory.title'.tr(),
//           style: AppTextStyles.titleMedium(AppColors.primary).copyWith(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         centerTitle: false,
//         actions: [
//           Container(
//             margin: EdgeInsets.only(right: AppSpacing.md.w),
//             width: 36.w,
//             height: 36.w,
//             decoration: BoxDecoration(
//               color: AppColors.primary,
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               padding: EdgeInsets.zero,
//               icon: Icon(Icons.add_rounded, size: 20.sp, color: Colors.white),
//               onPressed: () =>
//                   Navigator.pushNamed(context, AppRoutes.aiChat),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: AppSpacing.md.w,
//               vertical: AppSpacing.sm.h,
//             ),
//             child: SearchBar(
//               controller: _searchController,
//               onChanged: _onSearch,
//             ),
//           ),
//
//           //  Sessions List
//           Expanded(
//             child: _filtered.isEmpty
//                 ? EmptyState()
//                 : ListView.builder(
//               padding: EdgeInsets.only(
//                 top: AppSpacing.xs.h,
//                 bottom: AppSpacing.xl.h,
//               ),
//               itemCount: _filtered.length,
//               itemBuilder: (_, i) => SessionCard(
//                 session: _filtered[i],
//                 onTap: () =>
//                     Navigator.pushNamed(context, AppRoutes.aiChat),
//               ),
//             ),
//           ),
//
//           // View Archived Sessions
//           Padding(
//             padding: EdgeInsets.only(bottom: AppSpacing.lg.h),
//             child: GestureDetector(
//               onTap: () {},
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'chatHistory.viewArchived'.tr(),
//                     style: AppTextStyles.bodySmall(
//                       cs.onSurface.withOpacity(0.5),
//                     ).copyWith(fontSize: 12.sp),
//                   ),
//                   SizedBox(width: 4.w),
//                   Icon(
//                     Icons.archive_outlined,
//                     size: 14.sp,
//                     color: cs.onSurface.withOpacity(0.5),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChatSessionModel {
  final String id;
  final String title;
  final String preview;
  final String date;
  final int messageCount;
  final bool isActive;
  final String tag; // e.g. "Advanced", "#active"

  const ChatSessionModel({
    required this.id,
    required this.title,
    required this.preview,
    required this.date,
    required this.messageCount,
    required this.isActive,
    required this.tag,
  });
}

class ChatSessionsScreen extends StatefulWidget {
  const ChatSessionsScreen({super.key});

  @override
  State<ChatSessionsScreen> createState() => _ChatSessionsScreenState();
}

class _ChatSessionsScreenState extends State<ChatSessionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // final List<ChatSessionModel> _sessions = const [
  //   ChatSessionModel(
  //     id: '1',
  //     title: 'How to improv...',
  //     preview: "That's a great question. For...",
  //     date: '2d ago',
  //     messageCount: 17,
  //     isActive: true,
  //     tag: 'Advanced',
  //   ),
  //   ChatSessionModel(
  //     id: '2',
  //     title: 'Career...',
  //     preview: 'To reach Senior Cloud Engineer...',
  //     date: 'Yesterday',
  //     messageCount: 6,
  //     isActive: false,
  //     tag: '',
  //   ),
  //   ChatSessionModel(
  //     id: '3',
  //     title: 'Mock Interview...',
  //     preview: 'Explain the difference between...',
  //     date: 'Oct 12',
  //     messageCount: 40,
  //     isActive: false,
  //     tag: '#active',
  //   ),
  //   ChatSessionModel(
  //     id: '4',
  //     title: 'Optimizing SQL...',
  //     preview: 'By using EXPLAIN/ANALYZE to...',
  //     date: 'Oct 10',
  //     messageCount: 9,
  //     isActive: false,
  //     tag: '',
  //   ),
  // ];

  List<ChatSessionModel> get _filteredSessions {
    if (_query.trim().isEmpty) return _sessions;
    final lowerQuery = _query.toLowerCase();
    return _sessions
        .where((s) =>
    s.title.toLowerCase().contains(lowerQuery) ||
        s.preview.toLowerCase().contains(lowerQuery))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filtered = _filteredSessions;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'chatHistory.title'.tr(),
          style: AppTextStyles.titleMedium(context as Color),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.aiChat),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.aiChat),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppSpacing.sm.h),
            _buildSearchBar(context, colorScheme),
            SizedBox(height: AppSpacing.md.h),
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState(context, colorScheme)
                  : ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md.w,
                  vertical: AppSpacing.sm.h,
                ),
                itemCount: filtered.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: AppSpacing.sm.h),
                itemBuilder: (context, index) {
                  return _buildSessionCard(
                    context,
                    colorScheme,
                    filtered[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _query = value),
        style: AppTextStyles.bodyMedium(context as Color),
        decoration: InputDecoration(
          hintText: 'chatHistory.searchHint'.tr(),
          hintStyle: AppTextStyles.bodyMedium(context as Color).copyWith(
            color: colorScheme.onSurface.withOpacity(0.4),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          filled: true,
          fillColor: colorScheme.surfaceVariant.withOpacity(0.4),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md.w,
            vertical: AppSpacing.sm.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSessionCard(
      BuildContext context,
      ColorScheme colorScheme,
      ChatSessionModel session,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md.r),
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.aiChat),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md.w),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md.r),
          border: session.isActive
              ? Border(
            left: BorderSide(color: AppColors.primary, width: 3.w),
          )
              : null,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.tertiary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: AppSpacing.sm.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          session.title,
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (session.isActive) ...[
                        SizedBox(width: AppSpacing.xs.w),
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    session.preview,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSpacing.xs.h),
                  Row(
                    children: [
                      Text(
                        session.date,
                        style: AppTextStyles.labelSmall(context as Color).copyWith(
                          color: colorScheme.onSurface.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(width: AppSpacing.sm.w),
                      _buildChip(
                        context,
                        colorScheme,
                        '${session.messageCount} ${'chatHistory.messages'.tr()}',
                        colorScheme.onSurface.withOpacity(0.06),
                        colorScheme.onSurface.withOpacity(0.6),
                      ),
                      if (session.tag.isNotEmpty) ...[
                        SizedBox(width: AppSpacing.xs.w),
                        _buildChip(
                          context,
                          colorScheme,
                          session.tag,
                          AppColors.secondary.withOpacity(0.12),
                          AppColors.secondary,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: AppSpacing.xs.w),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurface.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(
      BuildContext context,
      ColorScheme colorScheme,
      String label,
      Color background,
      Color textColor,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xs.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.pill.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall(context).copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64.w,
              color: colorScheme.onSurface.withOpacity(0.3),
            ),
            SizedBox(height: AppSpacing.md.h),
            Text(
              'chatHistory.empty'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(context).copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
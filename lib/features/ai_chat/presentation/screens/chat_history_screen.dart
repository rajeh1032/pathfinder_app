import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/app_routes.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';

class ChatSidebarDrawer extends StatelessWidget {
  final String currentSessionId;
  final VoidCallback? onNewChat;

  const ChatSidebarDrawer({
    super.key,
    required this.currentSessionId,
    this.onNewChat,
  });

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      width: 300.w,
      backgroundColor: colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            _DrawerHeader(onNewChat: onNewChat),

            // ── Sessions List ──
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ChatSessionsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (state is ChatSessionsLoaded) {
                    if (state.sessions.isEmpty) {
                      return _EmptySessionsView();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm.w,
                        vertical: AppSpacing.sm.h,
                      ),
                      itemCount: state.sessions.length,
                      itemBuilder: (_, i) {
                        final session = state.sessions[i];
                        final isActive = session.id == currentSessionId;

                        return _SessionTile(
                          title: session.title,
                          isActive: isActive,
                          onTap: () {
                            Navigator.pop(context); // close drawer
                            if (!isActive) {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.aiChat,
                                arguments: session.id,
                              );
                            }
                          },
                          onDelete: () async {
                            await context
                                .read<ChatCubit>()
                                .deleteSession(session.id);
                          },
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),

            // ── Footer ──
            _DrawerFooter(),
          ],
        ),
      ),
    );
  }
}

// ─── Drawer Header ────────────────────────────────────────────
class _DrawerHeader extends StatelessWidget {
  final VoidCallback? onNewChat;
  const _DrawerHeader({this.onNewChat});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          // AI Avatar
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.psychology_rounded,
              size: 18.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),
          Expanded(
            child: Text(
              'chat.title'.tr(),
              style: AppTextStyles.titleSmall(colorScheme.onSurface)
                  .copyWith(fontSize: 14.sp),
            ),
          ),
          // New Chat button
          IconButton(
            onPressed: onNewChat,
            icon: Icon(
              Icons.edit_square,
              size: 20.sp,
              color: AppColors.primary,
            ),
            tooltip: 'chatHistory.newChat'.tr(),
          ),
        ],
      ),
    );
  }
}

// ─── Session Tile ─────────────────────────────────────────────
class _SessionTile extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _SessionTile({
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: Key(title),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: AppSpacing.md.w),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.md.r),
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: AppColors.error,
          size: 20.sp,
        ),
      ),
      confirmDismiss: (_) async {
        return await _showDeleteConfirm(context);
      },
      onDismissed: (_) => onDelete(),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(bottom: 4.h),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md.w,
            vertical: AppSpacing.sm.h,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md.r),
            border: isActive
                ? Border.all(color: AppColors.primary.withOpacity(0.3))
                : null,
          ),
          child: Row(
            children: [
              // Active indicator
              if (isActive)
                Container(
                  width: 3.w,
                  height: 16.h,
                  margin: EdgeInsets.only(right: AppSpacing.sm.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.pill.r),
                  ),
                ),
              Icon(
                Icons.chat_bubble_outline_rounded,
                size: 16.sp,
                color: isActive
                    ? AppColors.primary
                    : colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: AppSpacing.sm.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodyMedium(
                    isActive ? AppColors.primary : colorScheme.onSurface,
                  ).copyWith(
                    fontSize: 13.sp,
                    fontWeight:
                    isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirm(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('chatHistory.deleteTitle'.tr()),
        content: Text('chatHistory.deleteConfirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text('common.delete'.tr()),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

// ─── Empty Sessions ───────────────────────────────────────────
class _EmptySessionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 40.sp,
              color: colorScheme.onSurfaceVariant.withOpacity(0.4),
            ),
            SizedBox(height: AppSpacing.sm.h),
            Text(
              'chatHistory.empty'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall(colorScheme.onSurfaceVariant)
                  .copyWith(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Drawer Footer ────────────────────────────────────────────
class _DrawerFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
        ),
      ),
      child: Text(
        'chatHistory.clearHint'.tr(),
        style: AppTextStyles.labelSmall(colorScheme.onSurfaceVariant)
            .copyWith(fontSize: 11.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}
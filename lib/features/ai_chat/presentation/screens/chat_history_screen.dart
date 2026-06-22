import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/chat_session_tile.dart';

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
            _DrawerHeader(onNewChat: onNewChat),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ChatSessionsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }

                  final sessions = switch (state) {
                    ChatSessionsLoaded(:final sessions) => sessions,
                    ChatLoaded(:final sessions) => sessions,
                    _ => null,
                  };

                  if (sessions == null || sessions.isEmpty) {
                    return _EmptySessionsView();
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm.w,
                      vertical: AppSpacing.sm.h,
                    ),
                    itemCount: sessions.length,
                    itemBuilder: (_, i) {
                      final session = sessions[i];
                      final isActive = session.id == currentSessionId;

                      return ChatSessionTile(
                        id: session.id,
                        title: session.title,
                        status: session.status,
                        isActive: isActive,
                        onTap: () {
                          Navigator.pop(context);
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
                },
              ),
            ),
            _DrawerFooter(),
          ],
        ),
      ),
    );
  }
}

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
            color: colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.psychology_rounded,
              size: 18.sp,
              color: Theme.of(context).colorScheme.onPrimary,
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
          IconButton(
            onPressed: onNewChat,
            icon: Icon(
              Icons.edit_square,
              size: 20.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
            tooltip: 'chatHistory.newChat'.tr(),
          ),
        ],
      ),
    );
  }
}

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
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
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

class _DrawerFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
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

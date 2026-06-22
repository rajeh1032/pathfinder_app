import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChatSessionTile extends StatelessWidget {
  const ChatSessionTile({
    super.key,
    required this.id,
    required this.title,
    required this.status,
    required this.isActive,
    required this.onTap,
    required this.onDelete,
  });

  final String id;
  final String title;
  final String status;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isArchived = status == 'archived';

    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: AppSpacing.md.w),
        decoration: BoxDecoration(
          color: colors.error.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(AppRadius.md.r),
        ),
        child: Icon(Icons.delete_outline_rounded, color: colors.error),
      ),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => onDelete(),
      child: ListTile(
        onTap: onTap,
        selected: isActive,
        selectedColor: colors.primary,
        selectedTileColor: colors.primary.withValues(alpha: .1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md.r),
        ),
        leading: Icon(
          isArchived ? Icons.archive_outlined : Icons.chat_bubble_outline,
          size: 18.sp,
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyMedium(
            isActive ? colors.primary : colors.onSurface,
          ),
        ),
        trailing: isArchived
            ? Text(
                'chatHistory.archived'.tr(),
                style: AppTextStyles.labelSmall(colors.onSurfaceVariant),
              )
            : null,
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text('chatHistory.deleteTitle'.tr()),
            content: Text('chatHistory.deleteConfirm'.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text('common.cancel'.tr()),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text('common.delete'.tr()),
              ),
            ],
          ),
        ) ??
        false;
  }
}

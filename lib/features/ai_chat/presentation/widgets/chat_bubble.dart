import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isFromUser;

  const ChatBubble(
      {super.key, required this.message, required this.isFromUser});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Align(
      alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppSpacing.xs.h),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: AppSpacing.sm.h,
        ),
        constraints: BoxConstraints(maxWidth: 0.75.sw),
        decoration: BoxDecoration(
          color: isFromUser
              ? cs.primary
              : cs.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.md.r),
            topRight: Radius.circular(AppRadius.md.r),
            bottomLeft: Radius.circular(isFromUser ? AppRadius.md.r : 4.r),
            bottomRight: Radius.circular(isFromUser ? 4.r : AppRadius.md.r),
          ),
        ),
        child: isFromUser
            ? Text(
                message,
                style: AppTextStyles.bodyMedium(cs.onPrimary),
              )
            : MarkdownBody(
                data: message,
                softLineBreak: true,
                styleSheet: _markdownStyleSheet(context),
              ),
      ),
    );
  }

  MarkdownStyleSheet _markdownStyleSheet(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final bodyStyle = AppTextStyles.bodyMedium(cs.onSurface).copyWith(
      height: 1.55,
    );
    final blockquoteBorder = BorderSide(
      color: cs.primary.withValues(alpha: 0.45),
      width: 3.w,
    );

    return MarkdownStyleSheet.fromTheme(theme).copyWith(
      p: bodyStyle,
      strong: bodyStyle.copyWith(fontWeight: FontWeight.w700),
      em: bodyStyle.copyWith(fontStyle: FontStyle.italic),
      listBullet: bodyStyle,
      blockSpacing: AppSpacing.sm.h,
      listIndent: AppSpacing.lg.w,
      code: bodyStyle.copyWith(
        color: cs.primary,
        backgroundColor: cs.surface.withValues(alpha: 0.85),
        fontFamily: 'monospace',
      ),
      codeblockPadding: EdgeInsets.all(AppSpacing.sm.r),
      codeblockDecoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(AppRadius.sm.r),
      ),
      blockquote: bodyStyle.copyWith(color: cs.onSurfaceVariant),
      blockquotePadding: EdgeInsetsDirectional.only(
        start: AppSpacing.sm.w,
        top: AppSpacing.xs.h,
        bottom: AppSpacing.xs.h,
      ).resolve(Directionality.of(context)),
      blockquoteDecoration: BoxDecoration(
        border: isRtl
            ? Border(right: blockquoteBorder)
            : Border(left: blockquoteBorder),
      ),
    );
  }
}

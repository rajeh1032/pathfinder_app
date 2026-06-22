import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../ai_chat/presentation/cubit/chat_cubit.dart';

class HomeActionButtons extends StatelessWidget {
  const HomeActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            label: 'home.analyzeCv'.tr(),
            icon: Icons.description_outlined,
            isPrimary: true,
            onTap: () => Navigator.pushNamed(context, '/cv-upload'),
          ),
        ),
        SizedBox(width: AppSpacing.sm.w),
        Expanded(
          child: _ActionButton(
            label: 'home.chatWithAi'.tr(),
            icon: Icons.smart_toy_outlined,
            isPrimary: false,
            onTap: () async {
              final cubit = getIt<ChatCubit>();
              final session = await cubit.createSession();
              await cubit.close();
              if (!context.mounted) return;
              if (session != null) {
                Navigator.pushNamed(context, '/ai-chat', arguments: session.id);
              } else {
                CustomSnackbar.showError(
                  context: context,
                  message: 'common.error'.tr(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: AppSpacing.md.w,
        ),
        decoration: BoxDecoration(
          color: isPrimary
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.md.r),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isPrimary
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 6.w),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color:
                      isPrimary ? colorScheme.onPrimary : colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

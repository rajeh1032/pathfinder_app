import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pathfinder_app/core/constants/app_assets.dart';
import '../../../../core/theme/app_text_styles.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const GoogleSignInButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorScheme.outline, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          backgroundColor: colorScheme.surface,
        ),
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google "G" logo drawn with text (no svg dependency needed)
                  Image.asset(AppAssets.googleLogo, width: 20.w, height: 20.w),
                  SizedBox(width: 10.w),
                  Text(
                    'auth.loginWithGoogle'.tr(),
                    style: AppTextStyles.labelLarge(colorScheme.onSurface),
                  ),
                ],
              ),
      ),
    );
  }
}

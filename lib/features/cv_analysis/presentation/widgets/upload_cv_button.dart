import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class UploadCvButton extends StatelessWidget {
  const UploadCvButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, '/cv-upload'),
        icon: Icon(Icons.upload_file_rounded, size: 20.sp),
        label: Text(
          'Upload New CV'.tr(),
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md.r),
          ),
        ),
      ),
    );
  }
}

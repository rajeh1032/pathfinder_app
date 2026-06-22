import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/custom_button.dart';

class UploadCvButton extends StatelessWidget {
  const UploadCvButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      labelKey: 'cvAnalysis.uploadNewCv',
      onPressed: isLoading ? null : onPressed,
      icon: Icons.upload_file_rounded,
      variant: CustomButtonVariant.outline,
      isLoading: isLoading,
      height: 50.h,
    );
  }
}

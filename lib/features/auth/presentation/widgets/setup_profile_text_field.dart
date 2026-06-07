import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_text_styles.dart';

class OnboardingTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final IconData prefixIcon;
  final TextInputType keyboardType;

  const OnboardingTextField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    required this.onChanged,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium(colorScheme.onSurfaceVariant)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: AppTextStyles.bodyMedium(colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: Icon(
              prefixIcon,
              size: 20.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
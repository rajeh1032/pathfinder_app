import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_styles.dart';

class OnboardingDropdownField<T> extends StatelessWidget {
  final String label;
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final IconData prefixIcon;

  const OnboardingDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.prefixIcon,
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
        DropdownButtonFormField<T>(
          initialValue: value,
          hint: Text(hintText),
          decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              size: 20.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

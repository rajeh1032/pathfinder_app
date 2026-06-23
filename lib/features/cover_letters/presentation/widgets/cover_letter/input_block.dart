import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'shared_widgets.dart';

class InputBlock extends StatelessWidget {
  const InputBlock({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label),
        SizedBox(height: AppSpacing.xs.h),
        TextFormField(
          controller: controller,
          minLines: 3,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm.r),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm.r),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            contentPadding: EdgeInsets.all(10.w),
          ),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                height: 1.35,
                fontWeight: FontWeight.w500,
              ),
          strutStyle: const StrutStyle(
            forceStrutHeight: true,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

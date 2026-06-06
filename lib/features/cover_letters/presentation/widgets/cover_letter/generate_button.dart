import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_gradients.dart';
import '../../../../../core/theme/app_radius.dart';

class GenerateCoverLetterButton extends StatelessWidget {
  const GenerateCoverLetterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.aiTertiary,
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x336366F1),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: SizedBox(
        height: 52.h,
        child: TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.auto_awesome, color: Colors.white, size: 18.sp),
          label: Text(
            'coverLetter.generate'.tr(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
      ),
    );
  }
}

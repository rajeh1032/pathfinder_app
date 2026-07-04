import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedProgressCircle extends StatelessWidget {
  final AnimationController controller;

  const AnimatedProgressCircle({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer rotating gradient ring
        RotationTransition(
          turns: controller,
          child: Container(
            width: 110.w,
            height: 110.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                ],
              ),
            ),
          ),
        ),
        // Inner white circle
        Container(
          width: 90.w,
          height: 90.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Center(
            child: Icon(
              Icons.description_outlined,
              size: 36.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

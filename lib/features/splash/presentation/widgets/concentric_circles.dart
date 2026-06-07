import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConcentricCircles extends StatelessWidget {
  const ConcentricCircles({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (final size in [320.0, 240.0, 160.0])
            Container(
              width: size.w,
              height: size.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.primary.withAlpha(15),
                  width: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

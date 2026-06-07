import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class ResponsiveValue {
  const ResponsiveValue._();

  static double widthFactor(
    BuildContext context, {
    required double factor,
    required double min,
    required double max,
  }) {
    final width = MediaQuery.sizeOf(context).width * factor;
    return math.min(max, math.max(min, width));
  }

  static int columnsFor(
    BuildContext context, {
    int compact = 2,
    int medium = 3,
    int expanded = 4,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return expanded;
    if (width >= 600) return medium;
    return compact;
  }
}

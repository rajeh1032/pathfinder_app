import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {
  const AppGradients._();

  static const aiPrimary = LinearGradient(
    colors: [AppColors.primary, AppColors.secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const aiTertiary = LinearGradient(
    colors: [AppColors.primary, AppColors.tertiary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

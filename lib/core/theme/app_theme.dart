import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_gradients.dart';
import 'app_text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light => _theme(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: Colors.white,
          primaryContainer: AppColors.primaryContainer,
          onPrimaryContainer: AppColors.neutral900,
          secondary: AppColors.secondary,
          onSecondary: AppColors.neutral950,
          secondaryContainer: AppColors.secondaryContainer,
          onSecondaryContainer: AppColors.neutral900,
          tertiary: AppColors.tertiary,
          onTertiary: Colors.white,
          tertiaryContainer: AppColors.tertiaryContainer,
          onTertiaryContainer: AppColors.neutral900,
          error: AppColors.error,
          onError: Colors.white,
          surface: AppColors.lightSurface,
          onSurface: AppColors.lightText,
          surfaceContainerHighest: AppColors.lightSurfaceVariant,
          onSurfaceVariant: AppColors.lightTextMuted,
          outline: AppColors.lightBorder,
          outlineVariant: AppColors.neutral200,
          shadow: Color(0x1A0F172A),
          scrim: Color(0x66020617),
          inverseSurface: AppColors.neutral900,
          onInverseSurface: AppColors.neutral50,
          inversePrimary: AppColors.primarySoft,
        ),
      );

  static ThemeData get dark => _theme(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primary,
          onPrimary: Colors.white,
          primaryContainer: AppColors.primaryDark,
          onPrimaryContainer: AppColors.neutral50,
          secondary: AppColors.secondary,
          onSecondary: AppColors.neutral950,
          secondaryContainer: AppColors.secondaryDark,
          onSecondaryContainer: AppColors.neutral50,
          tertiary: AppColors.tertiary,
          onTertiary: Colors.white,
          tertiaryContainer: AppColors.tertiaryDark,
          onTertiaryContainer: AppColors.neutral50,
          error: AppColors.error,
          onError: Colors.white,
          surface: AppColors.darkSurface,
          onSurface: AppColors.darkText,
          surfaceContainerHighest: AppColors.darkSurfaceVariant,
          onSurfaceVariant: AppColors.darkTextMuted,
          outline: AppColors.darkBorder,
          outlineVariant: AppColors.neutral700,
          shadow: Color(0x66000000),
          scrim: Color(0x99000000),
          inverseSurface: AppColors.neutral50,
          onInverseSurface: AppColors.neutral900,
          inversePrimary: AppColors.primarySoft,
        ),
      );

  static ThemeData _theme({required ColorScheme colorScheme}) {
    final scaffoldColor = colorScheme.surface;

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldColor,
      fontFamily: AppTextStyles.fontFamily,
      textTheme: _textTheme(colorScheme),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldColor,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: _appBarTitleTextStyle(colorScheme),
        toolbarTextStyle: AppTextStyles.bodyMedium(colorScheme.onSurface),
        iconTheme: IconThemeData(color: colorScheme.primary, size: 22),
        actionsIconTheme: IconThemeData(
          color: colorScheme.primary,
          size: 22,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primary,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            color:
                selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
            fontSize: 12,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color:
                selected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
          );
        }),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  static TextTheme _textTheme(ColorScheme colorScheme) {
    final onSurface = colorScheme.onSurface;
    final onSurfaceVariant = colorScheme.onSurfaceVariant;

    return TextTheme(
      displayLarge: AppTextStyles.displayLarge(onSurface),
      displayMedium: AppTextStyles.displayMedium(onSurface),
      displaySmall: AppTextStyles.displaySmall(onSurface),
      headlineLarge: AppTextStyles.headlineLarge(onSurface),
      headlineMedium: AppTextStyles.headlineMedium(onSurface),
      headlineSmall: AppTextStyles.headlineSmall(onSurface),
      titleLarge: AppTextStyles.titleLarge(onSurface),
      titleMedium: AppTextStyles.titleMedium(onSurface),
      titleSmall: AppTextStyles.titleSmall(onSurface),
      bodyLarge: AppTextStyles.bodyLarge(onSurface),
      bodyMedium: AppTextStyles.bodyMedium(onSurface),
      bodySmall: AppTextStyles.bodySmall(onSurfaceVariant),
      labelLarge: AppTextStyles.labelLarge(onSurface),
      labelMedium: AppTextStyles.labelMedium(onSurfaceVariant),
      labelSmall: AppTextStyles.labelSmall(onSurfaceVariant),
    );
  }

  static TextStyle _appBarTitleTextStyle(ColorScheme colorScheme) {
    final baseStyle = AppTextStyles.titleLarge(colorScheme.primary);

    return TextStyle(
      fontFamily: baseStyle.fontFamily,
      fontSize: baseStyle.fontSize,
      fontWeight: baseStyle.fontWeight,
      height: baseStyle.height,
      letterSpacing: baseStyle.letterSpacing,
      foreground: Paint()
        ..shader = AppGradients.aiTertiary.createShader(
          const Rect.fromLTWH(0, 0, 240, 32),
        ),
    );
  }
}

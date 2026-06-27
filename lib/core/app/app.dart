import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_config.dart';
import 'app_keys.dart';
import '../di/di.dart';
import '../routing/app_router.dart';
import '../routing/app_routes.dart';
import '../theme/app_theme.dart';
import '../theme/app_theme_cubit.dart';

class PathFinderApp extends StatelessWidget {
  const PathFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppThemeCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (screenContext, child) =>
            BlocBuilder<AppThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              title: AppConfig.appName,
              debugShowCheckedModeBanner: false,
              navigatorKey: appNavigatorKey,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              initialRoute: AppRoutes.splash,
              builder: DevicePreview.appBuilder,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}

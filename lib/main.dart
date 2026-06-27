import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/app/app.dart';
import 'core/app/app_bloc_observer.dart';
import 'core/app/push_background_handler.dart';
import 'core/di/di.dart';
import 'core/localization/localization_service.dart';
import 'core/storage/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  await LocalStorage.init();
  await configureDependencies();
  Bloc.observer = AppBlocObserver();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      availableLocales: LocalizationService.supportedLocales,
      builder: (_) => EasyLocalization(
        supportedLocales: LocalizationService.supportedLocales,
        path: LocalizationService.translationsPath,
        fallbackLocale: LocalizationService.english,
        child: const PathFinderApp(),
      ),
    ),
  );
}

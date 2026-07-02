import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../core/di/di.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/remote/notifications_remote_data_source.dart';
import '../repositories/notifications_repository_impl.dart';
import 'push_messaging_service.dart';

/// Builds a [PushMessagingService] wired to the notifications backend.
PushMessagingService createPushMessagingService() {
  return _instance ??= _createPushMessagingService();
}

PushMessagingService? _instance;

PushMessagingService _createPushMessagingService() {
  final remoteDataSource =
      NotificationsRemoteDataSourceImpl(getIt<ApiClient>());
  final repository = NotificationsRepositoryImpl(
    remoteDataSource,
    getIt<NetworkInfo>(),
  );

  return PushMessagingService(
    messaging: getIt<FirebaseMessaging>(),
    localNotifications: getIt<FlutterLocalNotificationsPlugin>(),
    repository: repository,
  );
}

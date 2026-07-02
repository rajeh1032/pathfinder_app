import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../domain/repositories/notifications_repository.dart';
import '../../presentation/widgets/notification_navigator.dart';

/// Orchestrates Firebase Cloud Messaging: permission, device-token
/// registration with the backend, foreground display, and tap navigation.
class PushMessagingService {
  PushMessagingService({
    required FirebaseMessaging messaging,
    required FlutterLocalNotificationsPlugin localNotifications,
    required NotificationsRepository repository,
  })  : _messaging = messaging,
        _localNotifications = localNotifications,
        _repository = repository;

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final NotificationsRepository _repository;

  bool _listenersReady = false;

  static const _androidNotificationIcon = 'ic_stat_group_31_1';
  static const _androidNotificationColor = Color(0xFF4648D4);

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'pathfinder_default',
    'General Notifications',
    description: 'Career updates, job matches, and reminders.',
    importance: Importance.high,
  );

  /// Sets up local-notification plumbing and FCM listeners. Safe to call once.
  Future<void> bootstrap() async {
    if (_listenersReady) return;
    _listenersReady = true;

    await _initLocalNotifications();
    await _messaging.requestPermission();
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(_showForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOpenedMessage);
    _messaging.onTokenRefresh.listen(_onTokenRefresh);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleOpenedMessage(initialMessage);
    }
  }

  /// Fetches the FCM token and registers it with the backend (auth required).
  Future<void> registerDevice() async {
    final device = await getDeviceRegistration();
    if (device == null) return;
    await _repository.registerDevice(
      token: device.token,
      platform: device.platform,
    );
  }

  /// Returns token metadata for login/register without making auth depend on
  /// Firebase availability.
  Future<PushDeviceRegistration?> getDeviceRegistration() async {
    try {
      final token = await _messaging.getToken();
      if (token == null || token.isEmpty) return null;
      return PushDeviceRegistration(token: token, platform: _platform());
    } catch (_) {
      return null;
    }
  }

  /// Removes the current device token from the backend (call on logout).
  Future<void> unregisterDevice() async {
    final token = await _messaging.getToken();
    if (token == null || token.isEmpty) return;
    await _repository.unregisterDevice(token);
  }

  Future<void> _onTokenRefresh(String token) async {
    if (token.isEmpty) return;
    await _repository.registerDevice(token: token, platform: _platform());
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings(_androidNotificationIcon);
    const iosSettings = DarwinInitializationSettings();

    await _localNotifications.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: _onLocalNotificationTapped,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  void _showForegroundNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: _androidNotificationIcon,
          color: _androidNotificationColor,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: jsonEncode(message.data),
    );
  }

  void _handleOpenedMessage(RemoteMessage message) {
    NotificationNavigator.openFromData(message.data);
  }

  void _onLocalNotificationTapped(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;
    try {
      final data = (jsonDecode(payload) as Map).cast<String, dynamic>();
      NotificationNavigator.openFromData(data);
    } catch (_) {
      // Ignore malformed payloads.
    }
  }

  String _platform() {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    return 'web';
  }
}

class PushDeviceRegistration {
  const PushDeviceRegistration({required this.token, required this.platform});

  final String token;
  final String platform;
}

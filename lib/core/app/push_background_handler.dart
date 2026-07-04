import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Handles FCM messages received while the app is in the background or
/// terminated. Must be a top-level function annotated for the VM entry point.
///
/// Messages carrying a `notification` payload are shown in the system tray
/// automatically; this handler only ensures Firebase is ready for any
/// data-only processing.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

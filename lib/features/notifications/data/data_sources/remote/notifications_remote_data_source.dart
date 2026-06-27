import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../models/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    int limit = 50,
  });

  Future<NotificationModel> markAsRead(String id);

  Future<void> markAllAsRead();

  Future<void> dismissNotification(String id);

  Future<void> registerDevice({required String token, required String platform});

  Future<void> unregisterDevice(String token);
}

class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource {
  const NotificationsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    int limit = 50,
  }) async {
    final response = await _apiClient.get(
      ApiEndpoints.notifications,
      queryParameters: {'page': page, 'limit': limit},
    );
    return _parseList(response.data);
  }

  @override
  Future<NotificationModel> markAsRead(String id) async {
    final response = await _apiClient.patch(
      ApiEndpoints.markNotificationAsRead(id),
    );
    return _parseNotification(response.data);
  }

  @override
  Future<void> markAllAsRead() async {
    await _apiClient.patch(ApiEndpoints.notificationsReadAll);
  }

  @override
  Future<void> dismissNotification(String id) async {
    await _apiClient.delete(ApiEndpoints.dismissNotification(id));
  }

  @override
  Future<void> registerDevice({
    required String token,
    required String platform,
  }) async {
    await _apiClient.post(
      ApiEndpoints.notificationDevices,
      data: {'token': token, 'platform': platform},
    );
  }

  @override
  Future<void> unregisterDevice(String token) async {
    await _apiClient.delete(
      ApiEndpoints.notificationDevices,
      data: {'token': token},
    );
  }
}

List<NotificationModel> _parseList(Object? body) {
  final list = switch (body) {
    {'data': {'notifications': final List<dynamic> items}} => items,
    {'data': final List<dynamic> items} => items,
    final List<dynamic> items => items,
    _ => throw const FormatException('Unexpected notifications response format'),
  };

  return list
      .whereType<Map<String, dynamic>>()
      .map(NotificationModel.fromJson)
      .toList(growable: false);
}

NotificationModel _parseNotification(Object? body) {
  final json = switch (body) {
    {'data': {'notification': final Map<String, dynamic> item}} => item,
    {'data': final Map<String, dynamic> item} => item,
    final Map<String, dynamic> item => item,
    _ => throw const FormatException('Unexpected notification response format'),
  };
  return NotificationModel.fromJson(json);
}

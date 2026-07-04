import '../../../../core/di/di.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/network_info.dart';
import '../../data/data_sources/remote/notifications_remote_data_source.dart';
import '../../data/repositories/notifications_repository_impl.dart';
import '../../domain/use_cases/dismiss_notification_use_case.dart';
import '../../domain/use_cases/get_notifications_use_case.dart';
import '../../domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import '../../domain/use_cases/mark_notification_as_read_use_case.dart';
import 'notifications_cubit.dart';

NotificationsCubit createNotificationsCubit() {
  final remoteDataSource =
      NotificationsRemoteDataSourceImpl(getIt<ApiClient>());
  final repository = NotificationsRepositoryImpl(
    remoteDataSource,
    getIt<NetworkInfo>(),
  );

  return NotificationsCubit(
    getNotificationsUseCase: GetNotificationsUseCase(repository),
    markAsReadUseCase: MarkNotificationAsReadUseCase(repository),
    markAllAsReadUseCase: MarkAllNotificationsAsReadUseCase(repository),
    dismissNotificationUseCase: DismissNotificationUseCase(repository),
  );
}

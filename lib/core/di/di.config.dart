// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i163;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pathfinder_app/core/di/modules/core_module.dart' as _i812;
import 'package:pathfinder_app/core/di/modules/dio_module.dart' as _i168;
import 'package:pathfinder_app/core/di/modules/firebase_module.dart' as _i628;
import 'package:pathfinder_app/core/di/modules/storage_module.dart' as _i567;
import 'package:pathfinder_app/core/network/api_client.dart' as _i429;
import 'package:pathfinder_app/core/network/api_interceptor.dart' as _i834;
import 'package:pathfinder_app/core/network/network_info.dart' as _i874;
import 'package:pathfinder_app/core/storage/secure_storage.dart' as _i213;
import 'package:pathfinder_app/core/storage/token_storage.dart' as _i203;
import 'package:pathfinder_app/core/theme/app_theme_cubit.dart' as _i337;
import 'package:pathfinder_app/features/ai_chat/data/data_sources/remote/chat_remote_data_source.dart'
    as _i570;
import 'package:pathfinder_app/features/ai_chat/data/data_sources/remote/chat_remote_impl.dart'
    as _i479;
import 'package:pathfinder_app/features/ai_chat/data/repositories/chat_repository_impl.dart'
    as _i943;
import 'package:pathfinder_app/features/ai_chat/domain/repositories/chat_repo.dart'
    as _i262;
import 'package:pathfinder_app/features/ai_chat/presentation/cubit/chat_cubit.dart'
    as _i356;
import 'package:pathfinder_app/features/auth/presentation/cubit/register_cubit.dart'
    as _i73;
import 'package:pathfinder_app/features/auth/presentation/cubit/setup_profile_cubit.dart'
    as _i570;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final storageModule = _$StorageModule();
    final coreModule = _$CoreModule();
    final firebaseModule = _$FirebaseModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i73.RegisterCubit>(() => _i73.RegisterCubit());
    gh.factory<_i570.SetupProfileCubit>(() => _i570.SetupProfileCubit());
    gh.lazySingleton<_i895.Connectivity>(() => coreModule.connectivity);
    gh.lazySingleton<_i892.FirebaseMessaging>(
        () => firebaseModule.firebaseMessaging);
    gh.lazySingleton<_i163.FlutterLocalNotificationsPlugin>(
        () => firebaseModule.localNotifications);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => storageModule.secureStorage);
    gh.lazySingleton<_i337.AppThemeCubit>(() => _i337.AppThemeCubit());
    gh.lazySingleton<_i213.SecureStorage>(
        () => _i213.SecureStorage(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i874.NetworkInfo>(
        () => _i874.NetworkInfo(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i203.TokenStorage>(
        () => _i203.TokenStorage(gh<_i213.SecureStorage>()));
    gh.lazySingleton<_i834.ApiInterceptor>(
        () => _i834.ApiInterceptor(gh<_i203.TokenStorage>()));
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.dio(gh<_i834.ApiInterceptor>()));
    gh.lazySingleton<_i570.ChatRemoteDataSource>(
        () => _i479.ChatRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i429.ApiClient>(() => _i429.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i262.ChatRepository>(
        () => _i943.ChatRepositoryImpl(gh<_i570.ChatRemoteDataSource>()));
    gh.factory<_i356.ChatCubit>(
        () => _i356.ChatCubit(gh<_i262.ChatRepository>()));
    return this;
  }
}

class _$StorageModule extends _i567.StorageModule {}

class _$CoreModule extends _i812.CoreModule {}

class _$FirebaseModule extends _i628.FirebaseModule {}

class _$DioModule extends _i168.DioModule {}

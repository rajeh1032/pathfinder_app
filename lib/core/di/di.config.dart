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
import 'package:pathfinder_app/features/auth/data/data_sources/local/auth_local_data_source.dart'
    as _i120;
import 'package:pathfinder_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i310;
import 'package:pathfinder_app/features/auth/data/repositories/auth_repository_impl.dart'
    as _i570;
import 'package:pathfinder_app/features/auth/domain/repositories/auth_repository.dart'
    as _i405;
import 'package:pathfinder_app/features/auth/domain/use_cases/login_use_case.dart'
    as _i203;
import 'package:pathfinder_app/features/auth/domain/use_cases/register_use_case.dart'
    as _i338;
import 'package:pathfinder_app/features/auth/presentation/cubit/login_cubit.dart'
    as _i753;
import 'package:pathfinder_app/features/auth/presentation/cubit/register_cubit.dart'
    as _i73;
import 'package:pathfinder_app/features/career_paths/data/data_sources/remote/career_paths_remote_data_source.dart'
    as _i714;
import 'package:pathfinder_app/features/career_paths/data/repositories/career_paths_repository_impl.dart'
    as _i387;
import 'package:pathfinder_app/features/career_paths/domain/repositories/career_paths_repository.dart'
    as _i631;
import 'package:pathfinder_app/features/career_paths/domain/use_cases/get_career_paths_use_case.dart'
    as _i123;
import 'package:pathfinder_app/features/career_paths/presentation/cubit/career_paths_cubit.dart'
    as _i926;
import 'package:pathfinder_app/features/courses/data/data_sources/remote/courses_remote_data_source.dart'
    as _i501;
import 'package:pathfinder_app/features/courses/data/repositories/courses_repository_impl.dart'
    as _i773;
import 'package:pathfinder_app/features/courses/domain/repositories/courses_repository.dart'
    as _i893;
import 'package:pathfinder_app/features/courses/domain/use_cases/enroll_course_use_case.dart'
    as _i373;
import 'package:pathfinder_app/features/courses/domain/use_cases/get_course_details_use_case.dart'
    as _i769;
import 'package:pathfinder_app/features/courses/domain/use_cases/get_courses_use_case.dart'
    as _i582;
import 'package:pathfinder_app/features/courses/domain/use_cases/get_enrollments_use_case.dart'
    as _i841;
import 'package:pathfinder_app/features/courses/domain/use_cases/get_recommended_courses_use_case.dart'
    as _i661;
import 'package:pathfinder_app/features/courses/domain/use_cases/get_saved_courses_use_case.dart'
    as _i296;
import 'package:pathfinder_app/features/courses/domain/use_cases/save_course_use_case.dart'
    as _i655;
import 'package:pathfinder_app/features/courses/domain/use_cases/update_enrollment_use_case.dart'
    as _i355;
import 'package:pathfinder_app/features/courses/presentation/cubit/course_details_cubit.dart'
    as _i1063;
import 'package:pathfinder_app/features/courses/presentation/cubit/courses_catalog_cubit.dart'
    as _i284;
import 'package:pathfinder_app/features/courses/presentation/cubit/saved_courses_cubit.dart'
    as _i976;
import 'package:pathfinder_app/features/jobs/data/data_sources/remote/saved_jobs_remote_data_source.dart'
    as _i733;
import 'package:pathfinder_app/features/jobs/data/repositories/saved_jobs_repository_impl.dart'
    as _i535;
import 'package:pathfinder_app/features/jobs/domain/repositories/saved_jobs_repository.dart'
    as _i1071;
import 'package:pathfinder_app/features/jobs/domain/use_cases/get_saved_jobs_use_case.dart'
    as _i344;
import 'package:pathfinder_app/features/jobs/presentation/cubit/saved_jobs_cubit.dart'
    as _i506;
import 'package:pathfinder_app/features/profile/data/data_sources/remote/profile_remote_data_source.dart'
    as _i977;
import 'package:pathfinder_app/features/profile/data/repositories/user_profile_repository_impl.dart'
    as _i891;
import 'package:pathfinder_app/features/profile/domain/repositories/user_profile_repository.dart'
    as _i617;
import 'package:pathfinder_app/features/profile/domain/use_cases/create_education_use_case.dart'
    as _i587;
import 'package:pathfinder_app/features/profile/domain/use_cases/create_experience_use_case.dart'
    as _i896;
import 'package:pathfinder_app/features/profile/domain/use_cases/delete_education_use_case.dart'
    as _i995;
import 'package:pathfinder_app/features/profile/domain/use_cases/delete_experience_use_case.dart'
    as _i495;
import 'package:pathfinder_app/features/profile/domain/use_cases/get_education_use_case.dart'
    as _i300;
import 'package:pathfinder_app/features/profile/domain/use_cases/get_experiences_use_case.dart'
    as _i377;
import 'package:pathfinder_app/features/profile/domain/use_cases/get_my_profile_use_case.dart'
    as _i612;
import 'package:pathfinder_app/features/profile/domain/use_cases/update_education_use_case.dart'
    as _i788;
import 'package:pathfinder_app/features/profile/domain/use_cases/update_experience_use_case.dart'
    as _i560;
import 'package:pathfinder_app/features/profile/domain/use_cases/update_my_profile_use_case.dart'
    as _i925;
import 'package:pathfinder_app/features/profile/presentation/cubit/my_profile_cubit.dart'
    as _i694;
import 'package:pathfinder_app/features/roadmaps/data/data_sources/remote/roadmaps_remote_data_source.dart'
    as _i991;
import 'package:pathfinder_app/features/roadmaps/data/repositories/roadmaps_repository_impl.dart'
    as _i736;
import 'package:pathfinder_app/features/roadmaps/domain/repositories/roadmaps_repository.dart'
    as _i445;
import 'package:pathfinder_app/features/roadmaps/domain/use_cases/generate_roadmap_use_case.dart'
    as _i741;
import 'package:pathfinder_app/features/roadmaps/domain/use_cases/get_my_roadmap_use_case.dart'
    as _i844;
import 'package:pathfinder_app/features/roadmaps/domain/use_cases/get_roadmap_details_use_case.dart'
    as _i1033;
import 'package:pathfinder_app/features/roadmaps/domain/use_cases/update_roadmap_step_progress_use_case.dart'
    as _i315;
import 'package:pathfinder_app/features/roadmaps/presentation/cubit/roadmaps_cubit.dart'
    as _i1070;
import 'package:pathfinder_app/features/settings/presentation/cubit/account_identity_cubit.dart'
    as _i751;
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
    gh.lazySingleton<_i120.AuthLocalDataSource>(
        () => _i120.AuthLocalDataSourceImpl(gh<_i203.TokenStorage>()));
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.dio(gh<_i834.ApiInterceptor>()));
    gh.lazySingleton<_i570.ChatRemoteDataSource>(
        () => _i479.ChatRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i429.ApiClient>(() => _i429.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i733.SavedJobsRemoteDataSource>(
        () => _i733.SavedJobsRemoteDataSourceImpl(gh<_i429.ApiClient>()));
    gh.lazySingleton<_i262.ChatRepository>(
        () => _i943.ChatRepositoryImpl(gh<_i570.ChatRemoteDataSource>()));
    gh.lazySingleton<_i310.AuthRemoteDataSource>(
        () => _i310.AuthRemoteDataSourceImpl(gh<_i429.ApiClient>()));
    gh.lazySingleton<_i501.CoursesRemoteDataSource>(
        () => _i501.CoursesRemoteDataSourceImpl(gh<_i429.ApiClient>()));
    gh.lazySingleton<_i893.CoursesRepository>(() => _i773.CoursesRepositoryImpl(
          gh<_i501.CoursesRemoteDataSource>(),
          gh<_i874.NetworkInfo>(),
        ));
    gh.lazySingleton<_i991.RoadmapsRemoteDataSource>(
        () => _i991.RoadmapsRemoteDataSourceImpl(gh<_i429.ApiClient>()));
    gh.lazySingleton<_i714.CareerPathsRemoteDataSource>(
        () => _i714.CareerPathsRemoteDataSourceImpl(gh<_i429.ApiClient>()));
    gh.lazySingleton<_i977.ProfileRemoteDataSource>(
        () => _i977.ProfileRemoteDataSourceImpl(gh<_i429.ApiClient>()));
    gh.lazySingleton<_i617.UserProfileRepository>(
        () => _i891.UserProfileRepositoryImpl(
              gh<_i977.ProfileRemoteDataSource>(),
              gh<_i874.NetworkInfo>(),
            ));
    gh.factory<_i356.ChatCubit>(
        () => _i356.ChatCubit(gh<_i262.ChatRepository>()));
    gh.lazySingleton<_i405.AuthRepository>(() => _i570.AuthRepositoryImpl(
          gh<_i310.AuthRemoteDataSource>(),
          gh<_i120.AuthLocalDataSource>(),
          gh<_i874.NetworkInfo>(),
        ));
    gh.lazySingleton<_i631.CareerPathsRepository>(
        () => _i387.CareerPathsRepositoryImpl(
              gh<_i714.CareerPathsRemoteDataSource>(),
              gh<_i874.NetworkInfo>(),
            ));
    gh.lazySingleton<_i373.EnrollCourseUseCase>(
        () => _i373.EnrollCourseUseCase(gh<_i893.CoursesRepository>()));
    gh.lazySingleton<_i769.GetCourseDetailsUseCase>(
        () => _i769.GetCourseDetailsUseCase(gh<_i893.CoursesRepository>()));
    gh.lazySingleton<_i582.GetCoursesUseCase>(
        () => _i582.GetCoursesUseCase(gh<_i893.CoursesRepository>()));
    gh.lazySingleton<_i841.GetEnrollmentsUseCase>(
        () => _i841.GetEnrollmentsUseCase(gh<_i893.CoursesRepository>()));
    gh.lazySingleton<_i661.GetRecommendedCoursesUseCase>(() =>
        _i661.GetRecommendedCoursesUseCase(gh<_i893.CoursesRepository>()));
    gh.lazySingleton<_i296.GetSavedCoursesUseCase>(
        () => _i296.GetSavedCoursesUseCase(gh<_i893.CoursesRepository>()));
    gh.lazySingleton<_i655.SaveCourseUseCase>(
        () => _i655.SaveCourseUseCase(gh<_i893.CoursesRepository>()));
    gh.lazySingleton<_i655.UnsaveCourseUseCase>(
        () => _i655.UnsaveCourseUseCase(gh<_i893.CoursesRepository>()));
    gh.lazySingleton<_i355.UpdateEnrollmentUseCase>(
        () => _i355.UpdateEnrollmentUseCase(gh<_i893.CoursesRepository>()));
    gh.lazySingleton<_i123.GetCareerPathsUseCase>(
        () => _i123.GetCareerPathsUseCase(gh<_i631.CareerPathsRepository>()));
    gh.lazySingleton<_i1071.SavedJobsRepository>(
        () => _i535.SavedJobsRepositoryImpl(
              gh<_i733.SavedJobsRemoteDataSource>(),
              gh<_i874.NetworkInfo>(),
            ));
    gh.lazySingleton<_i445.RoadmapsRepository>(
        () => _i736.RoadmapsRepositoryImpl(
              gh<_i991.RoadmapsRemoteDataSource>(),
              gh<_i874.NetworkInfo>(),
            ));
    gh.lazySingleton<_i587.CreateEducationUseCase>(
        () => _i587.CreateEducationUseCase(gh<_i617.UserProfileRepository>()));
    gh.lazySingleton<_i896.CreateExperienceUseCase>(
        () => _i896.CreateExperienceUseCase(gh<_i617.UserProfileRepository>()));
    gh.lazySingleton<_i995.DeleteEducationUseCase>(
        () => _i995.DeleteEducationUseCase(gh<_i617.UserProfileRepository>()));
    gh.lazySingleton<_i495.DeleteExperienceUseCase>(
        () => _i495.DeleteExperienceUseCase(gh<_i617.UserProfileRepository>()));
    gh.lazySingleton<_i300.GetEducationUseCase>(
        () => _i300.GetEducationUseCase(gh<_i617.UserProfileRepository>()));
    gh.lazySingleton<_i377.GetExperiencesUseCase>(
        () => _i377.GetExperiencesUseCase(gh<_i617.UserProfileRepository>()));
    gh.lazySingleton<_i612.GetMyProfileUseCase>(
        () => _i612.GetMyProfileUseCase(gh<_i617.UserProfileRepository>()));
    gh.lazySingleton<_i788.UpdateEducationUseCase>(
        () => _i788.UpdateEducationUseCase(gh<_i617.UserProfileRepository>()));
    gh.lazySingleton<_i560.UpdateExperienceUseCase>(
        () => _i560.UpdateExperienceUseCase(gh<_i617.UserProfileRepository>()));
    gh.lazySingleton<_i925.UpdateMyProfileUseCase>(
        () => _i925.UpdateMyProfileUseCase(gh<_i617.UserProfileRepository>()));
    gh.factory<_i926.CareerPathsCubit>(
        () => _i926.CareerPathsCubit(gh<_i123.GetCareerPathsUseCase>()));
    gh.factory<_i284.CoursesCatalogCubit>(() => _i284.CoursesCatalogCubit(
          gh<_i582.GetCoursesUseCase>(),
          gh<_i661.GetRecommendedCoursesUseCase>(),
          gh<_i296.GetSavedCoursesUseCase>(),
          gh<_i841.GetEnrollmentsUseCase>(),
          gh<_i655.SaveCourseUseCase>(),
          gh<_i655.UnsaveCourseUseCase>(),
        ));
    gh.factory<_i1063.CourseDetailsCubit>(() => _i1063.CourseDetailsCubit(
          gh<_i769.GetCourseDetailsUseCase>(),
          gh<_i655.SaveCourseUseCase>(),
          gh<_i655.UnsaveCourseUseCase>(),
          gh<_i373.EnrollCourseUseCase>(),
          gh<_i355.UpdateEnrollmentUseCase>(),
        ));
    gh.lazySingleton<_i344.GetSavedJobsUseCase>(
        () => _i344.GetSavedJobsUseCase(gh<_i1071.SavedJobsRepository>()));
    gh.lazySingleton<_i741.GenerateRoadmapUseCase>(
        () => _i741.GenerateRoadmapUseCase(gh<_i445.RoadmapsRepository>()));
    gh.lazySingleton<_i844.GetMyRoadmapUseCase>(
        () => _i844.GetMyRoadmapUseCase(gh<_i445.RoadmapsRepository>()));
    gh.lazySingleton<_i1033.GetRoadmapDetailsUseCase>(
        () => _i1033.GetRoadmapDetailsUseCase(gh<_i445.RoadmapsRepository>()));
    gh.lazySingleton<_i315.UpdateRoadmapStepProgressUseCase>(() =>
        _i315.UpdateRoadmapStepProgressUseCase(gh<_i445.RoadmapsRepository>()));
    gh.lazySingleton<_i203.LoginUseCase>(
        () => _i203.LoginUseCase(gh<_i405.AuthRepository>()));
    gh.lazySingleton<_i338.RegisterUseCase>(
        () => _i338.RegisterUseCase(gh<_i405.AuthRepository>()));
    gh.factory<_i506.SavedJobsCubit>(
        () => _i506.SavedJobsCubit(gh<_i344.GetSavedJobsUseCase>()));
    gh.factory<_i976.SavedCoursesCubit>(
        () => _i976.SavedCoursesCubit(gh<_i296.GetSavedCoursesUseCase>()));
    gh.factory<_i1070.RoadmapsCubit>(() => _i1070.RoadmapsCubit(
          gh<_i844.GetMyRoadmapUseCase>(),
          gh<_i741.GenerateRoadmapUseCase>(),
          gh<_i1033.GetRoadmapDetailsUseCase>(),
          gh<_i315.UpdateRoadmapStepProgressUseCase>(),
        ));
    gh.factory<_i751.AccountIdentityCubit>(() => _i751.AccountIdentityCubit(
          gh<_i612.GetMyProfileUseCase>(),
          gh<_i123.GetCareerPathsUseCase>(),
          gh<_i203.TokenStorage>(),
        ));
    gh.factory<_i694.MyProfileCubit>(() => _i694.MyProfileCubit(
          gh<_i612.GetMyProfileUseCase>(),
          gh<_i925.UpdateMyProfileUseCase>(),
          gh<_i377.GetExperiencesUseCase>(),
          gh<_i896.CreateExperienceUseCase>(),
          gh<_i560.UpdateExperienceUseCase>(),
          gh<_i495.DeleteExperienceUseCase>(),
          gh<_i300.GetEducationUseCase>(),
          gh<_i587.CreateEducationUseCase>(),
          gh<_i788.UpdateEducationUseCase>(),
          gh<_i995.DeleteEducationUseCase>(),
        ));
    gh.factory<_i753.LoginCubit>(
        () => _i753.LoginCubit(gh<_i203.LoginUseCase>()));
    return this;
  }
}

class _$StorageModule extends _i567.StorageModule {}

class _$CoreModule extends _i812.CoreModule {}

class _$FirebaseModule extends _i628.FirebaseModule {}

class _$DioModule extends _i168.DioModule {}

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:hive_ce_flutter/hive_flutter.dart' as _i919;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/admin/data/repositories/admin_repository_impl.dart'
    as _i335;
import '../../features/admin/domain/repositories/admin_repository.dart'
    as _i583;
import '../../features/admin/domain/use_cases/admin_use_cases.dart' as _i228;
import '../../features/attendance/data/datasources/attendance_firestore_datasource.dart'
    as _i673;
import '../../features/attendance/data/datasources/attendance_local_datasource.dart'
    as _i673;
import '../../features/attendance/data/repositories/attendance_repository_impl.dart'
    as _i719;
import '../../features/attendance/domain/repositories/attendance_repository.dart'
    as _i477;
import '../../features/attendance/domain/use_cases/attendance_use_cases.dart'
    as _i302;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/use_cases/auth_use_cases.dart' as _i336;
import '../../features/auth/presentation/blocs/auth_bloc.dart' as _i85;
import '../../features/localization/cache/localization_cache_manager.dart'
    as _i195;
import '../../features/localization/data/datasources/local_localization_datasource.dart'
    as _i808;
import '../../features/localization/data/datasources/remote_localization_api.dart'
    as _i727;
import '../../features/localization/data/repository/localization_repository_impl.dart'
    as _i533;
import '../../features/localization/domain/repository/localization_repository.dart'
    as _i807;
import '../../features/localization/domain/usecases/get_translations_use_case.dart'
    as _i755;
import '../../features/localization/presentation/services/localization_service.dart'
    as _i219;
import '../firebase/admin_push_notification_service.dart' as _i428;
import '../firebase/firebase_module.dart' as _i1055;
import '../firebase/push_notification_navigator.dart' as _i550;
import '../navigation/app_router.dart' as _i630;
import '../network/dio_content_type_interceptor.dart' as _i658;
import '../network/dio_module.dart' as _i614;
import '../services/connectivity_service.dart' as _i47;
import '../services/location_service.dart' as _i669;
import '../storage/hive/schema.dart' as _i787;
import 'service_locator.dart' as _i105;

const String _production = 'production';
const String _local = 'local';
const String _staging = 'staging';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final hiveModule = _$HiveModule();
    final storageModule = _$StorageModule();
    final firebaseModule = _$FirebaseModule();
    final connectivityModule = _$ConnectivityModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i919.Box<_i787.PendingAttendanceLog>>(
      () => hiveModule.pendingAttendanceBox(),
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.prefs,
      preResolve: true,
    );
    gh.factory<_i658.DioContentTypeInterceptor>(
      () => _i658.DioContentTypeInterceptor(),
    );
    gh.factory<_i195.LocalizationCacheManager>(
      () => _i195.LocalizationCacheManager(),
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.lazySingleton<_i428.AdminPushNotificationService>(
      () => _i428.AdminPushNotificationService(),
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i895.Connectivity>(() => connectivityModule.connectivity);
    gh.lazySingleton<_i669.LocationService>(() => _i669.LocationService());
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.getPublicApiDioClient(),
      instanceName: 'publicApiClient',
    );
    gh.factory<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.getFirebaseApiDioClient(),
      instanceName: 'firebaseApiClient',
    );
    gh.factory<_i727.RemoteLocalizationApi>(
      () => _i727.RemoteLocalizationApiImpl(
        gh<_i361.Dio>(instanceName: 'firebaseApiClient'),
      ),
      registerFor: {_production, _local, _staging},
    );
    gh.factory<_i808.LocalLocalizationDatasource>(
      () => const _i808.LocalLocalizationDatasourceImpl(),
    );
    gh.factory<_i673.AttendanceLocalDatasource>(
      () => _i673.AttendanceLocalDatasourceImpl(
        pendingBox: gh<_i738.Box<_i787.PendingAttendanceLog>>(),
      ),
    );
    gh.lazySingleton<_i47.ConnectivityService>(
      () => _i47.ConnectivityService(gh<_i895.Connectivity>()),
    );
    gh.factory<_i807.LocalizationRepository>(
      () => _i533.LocalizationRepositoryImpl(
        api: gh<_i727.RemoteLocalizationApi>(),
        local: gh<_i808.LocalLocalizationDatasource>(),
        cache: gh<_i195.LocalizationCacheManager>(),
      ),
    );
    gh.factory<_i673.AttendanceFirestoreDatasource>(
      () => _i673.AttendanceFirestoreDatasourceImpl(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i336.LoginUseCase>(
      () => _i336.LoginUseCase(authRepository: gh<_i787.AuthRepository>()),
    );
    gh.factory<_i336.RegisterUseCase>(
      () => _i336.RegisterUseCase(authRepository: gh<_i787.AuthRepository>()),
    );
    gh.factory<_i336.LogoutUseCase>(
      () => _i336.LogoutUseCase(authRepository: gh<_i787.AuthRepository>()),
    );
    gh.factory<_i336.WatchAuthUserUseCase>(
      () => _i336.WatchAuthUserUseCase(
        authRepository: gh<_i787.AuthRepository>(),
      ),
    );
    gh.lazySingleton<_i85.AuthBloc>(
      () => _i85.AuthBloc(
        loginUseCase: gh<_i336.LoginUseCase>(),
        registerUseCase: gh<_i336.RegisterUseCase>(),
        logoutUseCase: gh<_i336.LogoutUseCase>(),
        watchAuthUserUseCase: gh<_i336.WatchAuthUserUseCase>(),
        adminPushNotificationService: gh<_i428.AdminPushNotificationService>(),
      ),
    );
    gh.factory<_i583.AdminRepository>(
      () => _i335.AdminRepositoryImpl(
        firestore: gh<_i974.FirebaseFirestore>(),
        attendanceDatasource: gh<_i673.AttendanceFirestoreDatasource>(),
      ),
    );
    gh.factory<_i755.GetTranslationUsecase>(
      () => _i755.GetTranslationUsecase(gh<_i807.LocalizationRepository>()),
    );
    gh.singleton<_i630.AppRouter>(() => _i630.AppRouter(gh<_i85.AuthBloc>()));
    gh.factory<_i228.GetDashboardStatsUseCase>(
      () => _i228.GetDashboardStatsUseCase(
        adminRepository: gh<_i583.AdminRepository>(),
      ),
    );
    gh.factory<_i228.GetUsersUseCase>(
      () => _i228.GetUsersUseCase(adminRepository: gh<_i583.AdminRepository>()),
    );
    gh.factory<_i228.GetUserAttendanceHistoryUseCase>(
      () => _i228.GetUserAttendanceHistoryUseCase(
        adminRepository: gh<_i583.AdminRepository>(),
      ),
    );
    gh.factory<_i477.AttendanceRepository>(
      () => _i719.AttendanceRepositoryImpl(
        firestoreDatasource: gh<_i673.AttendanceFirestoreDatasource>(),
        localDatasource: gh<_i673.AttendanceLocalDatasource>(),
        locationService: gh<_i669.LocationService>(),
        connectivityService: gh<_i47.ConnectivityService>(),
      ),
    );
    gh.lazySingleton<_i219.LocalizationService>(
      () => _i219.LocalizationService(
        gh<_i755.GetTranslationUsecase>(),
        gh<_i195.LocalizationCacheManager>(),
      ),
    );
    gh.lazySingleton<_i550.PushNotificationNavigator>(
      () => _i550.PushNotificationNavigator(gh<_i630.AppRouter>()),
    );
    gh.factory<_i302.GetMyAttendanceHistoryUseCase>(
      () => _i302.GetMyAttendanceHistoryUseCase(
        attendanceRepository: gh<_i477.AttendanceRepository>(),
      ),
    );
    gh.factory<_i302.GetAttendanceStatusUseCase>(
      () => _i302.GetAttendanceStatusUseCase(
        attendanceRepository: gh<_i477.AttendanceRepository>(),
      ),
    );
    gh.factory<_i302.CheckInUseCase>(
      () => _i302.CheckInUseCase(
        attendanceRepository: gh<_i477.AttendanceRepository>(),
      ),
    );
    gh.factory<_i302.CheckOutUseCase>(
      () => _i302.CheckOutUseCase(
        attendanceRepository: gh<_i477.AttendanceRepository>(),
      ),
    );
    gh.factory<_i302.SyncPendingAttendanceUseCase>(
      () => _i302.SyncPendingAttendanceUseCase(
        attendanceRepository: gh<_i477.AttendanceRepository>(),
      ),
    );
    return this;
  }
}

class _$HiveModule extends _i105.HiveModule {}

class _$StorageModule extends _i105.StorageModule {}

class _$FirebaseModule extends _i1055.FirebaseModule {}

class _$ConnectivityModule extends _i47.ConnectivityModule {}

class _$DioModule extends _i614.DioModule {}

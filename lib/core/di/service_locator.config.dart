// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:fresh_dio/fresh_dio.dart' as _i856;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:hive_ce_flutter/hive_flutter.dart' as _i919;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/data_sources/auth_api.dart' as _i567;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/data/repositories/auth_token_repository_impl.dart'
    as _i44;
import '../../features/auth/data/repositories/user_session_repository_impl.dart'
    as _i723;
import '../../features/auth/domain/entities/auth_token_pair.dart' as _i178;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/repositories/auth_token_repository.dart'
    as _i773;
import '../../features/auth/domain/repositories/user_session_repository.dart'
    as _i191;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/logout_use_case.dart' as _i698;
import '../../features/auth/presentation/blocs/auth_bloc.dart' as _i85;
import '../../features/experiment/data/data_sources.dart/mock_api.dart'
    as _i362;
import '../../features/experiment/data/repositories/mock_repository_impl.dart'
    as _i665;
import '../../features/experiment/domain/repositories/mock_repository.dart'
    as _i557;
import '../../features/experiment/domain/use_cases/request_use_case.dart'
    as _i556;
import '../../features/experiment/presentation/blocs/mock_bloc.dart' as _i0;
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
import '../../features/notification/data/data_sources/notification_api.dart'
    as _i737;
import '../../features/notification/data/repositories/remote_notification_repository_impl.dart'
    as _i120;
import '../../features/notification/domain/repositories/remote_notification_repository.dart'
    as _i478;
import '../../features/notification/domain/use_cases/get_notifications_use_case.dart'
    as _i571;
import '../../features/notification/presentation/bloc/notifications_bloc.dart'
    as _i65;
import '../../features/product/data/data_sources/product_api.dart' as _i109;
import '../../features/product/data/repositories/product_repository_impl.dart'
    as _i1040;
import '../../features/product/domain/repositories/product_repository.dart'
    as _i39;
import '../../features/product/domain/usecases/get_product_use_case.dart'
    as _i247;
import '../../features/product/domain/usecases/get_products_use_case.dart'
    as _i936;
import '../../features/product/domain/usecases/search_products_use_case.dart'
    as _i529;
import '../../features/product/presentation/bloc/product_detail_bloc.dart'
    as _i1052;
import '../../features/product/presentation/bloc/products_bloc.dart' as _i9;
import '../../features/profile/domain/usecases/get_stored_user_profile_use_case.dart'
    as _i157;
import '../../features/profile/presentation/cubit/profile_cubit.dart' as _i36;
import '../../features/to-do/data/datasources/note_local_datasource.dart'
    as _i944;
import '../../features/to-do/data/repositories/note_repository_impl.dart'
    as _i646;
import '../../features/to-do/domain/repositories/note_repository.dart' as _i102;
import '../../features/to-do/domain/usecases/delete_note_use_case.dart'
    as _i354;
import '../../features/to-do/domain/usecases/get_note_use_case.dart' as _i21;
import '../../features/to-do/domain/usecases/get_notes_use_case.dart' as _i798;
import '../../features/to-do/domain/usecases/new_note_use_case.dart' as _i894;
import '../../features/to-do/domain/usecases/save_note_use_case.dart' as _i532;
import '../../features/to-do/presentation/bloc/note_form_bloc.dart' as _i168;
import '../../features/to-do/presentation/bloc/notes_bloc.dart' as _i470;
import '../navigation/app_router.dart' as _i630;
import '../network/dio_content_type_interceptor.dart' as _i658;
import '../network/dio_module.dart' as _i614;
import '../network/refresh_token_interceptor.dart' as _i767;
import '../security/bloc/app_security_guard_bloc.dart' as _i661;
import '../storage/hive/schema.dart' as _i787;
import '../storage/secure_auth_token_storage.dart' as _i850;
import '../storage/secure_user_storage.dart' as _i275;
import 'service_locator.dart' as _i105;

const String _mock = 'mock';
const String _prod = 'prod';
const String _dev = 'dev';
const String _uat = 'uat';
const String _preprod = 'preprod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final hiveModule = _$HiveModule();
    final storageModule = _$StorageModule();
    final dioModule = _$DioModule();
    final refreshTokenInterceptorModule = _$RefreshTokenInterceptorModule();
    await gh.factoryAsync<_i919.Box<_i787.Note>>(
      () => hiveModule.notesBox(),
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.prefs,
      preResolve: true,
    );
    gh.factory<_i658.DioContentTypeInterceptor>(
      () => _i658.DioContentTypeInterceptor(),
    );
    gh.factory<_i661.AppSecurityGuardBloc>(() => _i661.AppSecurityGuardBloc());
    gh.factory<_i195.LocalizationCacheManager>(
      () => _i195.LocalizationCacheManager(),
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.getPublicApiDioClient(),
      instanceName: 'publicApiClient',
    );
    gh.factory<_i737.NotificationApi>(
      () => _i737.MockNotificationApiImpl(),
      registerFor: {_mock},
    );
    gh.factory<_i944.NoteLocalDatasource>(
      () =>
          _i944.NoteLocalDatasourceImpl(notesBox: gh<_i738.Box<_i787.Note>>()),
    );
    gh.factory<_i109.ProductApi>(
      () => _i109.MockProductApiImpl(),
      registerFor: {_mock},
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.getFirebaseApiDioClient(),
      instanceName: 'firebaseApiClient',
    );
    gh.factory<_i362.MockApiInterface>(
      () => _i362.MockMockApi(),
      registerFor: {_mock},
    );
    gh.factory<_i808.LocalLocalizationDatasource>(
      () => const _i808.LocalLocalizationDatasourceImpl(),
    );
    gh.factory<_i567.AuthApiInterface>(
      () => _i567.MockAuthApi(),
      registerFor: {_mock},
    );
    gh.factory<_i102.NoteRepository>(
      () => _i646.NoteRepositoryImpl(
        noteLocalDatasource: gh<_i944.NoteLocalDatasource>(),
      ),
    );
    gh.factory<_i727.RemoteLocalizationApi>(
      () => _i727.MockRemoteLocalizationApiImpl(),
      registerFor: {_mock},
    );
    gh.factory<_i362.MockApiInterface>(
      () => _i362.MockApi(gh<_i361.Dio>(instanceName: 'publicApiClient')),
      registerFor: {_prod, _dev, _uat, _preprod},
    );
    gh.factory<_i850.SecureAuthTokenStorage>(
      () => _i850.SecureAuthTokenStorage(
        secureStorage: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i275.SecureUserStorage>(
      () => _i275.SecureUserStorage(
        secureStorage: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i567.AuthApiInterface>(
      () => _i567.AuthApi(gh<_i361.Dio>(instanceName: 'publicApiClient')),
      registerFor: {_prod, _dev, _uat, _preprod},
    );
    gh.factory<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(authApi: gh<_i567.AuthApiInterface>()),
    );
    gh.factory<_i727.RemoteLocalizationApi>(
      () => _i727.RemoteLocalizationApiImpl(
        gh<_i361.Dio>(instanceName: 'firebaseApiClient'),
      ),
      registerFor: {_prod, _dev, _uat, _preprod},
    );
    gh.factory<_i856.Fresh<_i178.AuthTokenPair>>(
      () => refreshTokenInterceptorModule.refreshTokenInterceptor(
        gh<_i850.SecureAuthTokenStorage>(),
      ),
    );
    gh.factory<_i354.DeleteNoteUseCase>(
      () => _i354.DeleteNoteUseCase(noteRepository: gh<_i102.NoteRepository>()),
    );
    gh.factory<_i21.GetNoteUseCase>(
      () => _i21.GetNoteUseCase(noteRepository: gh<_i102.NoteRepository>()),
    );
    gh.factory<_i798.GetNotesUseCase>(
      () => _i798.GetNotesUseCase(noteRepository: gh<_i102.NoteRepository>()),
    );
    gh.factory<_i894.NewNoteUseCase>(
      () => _i894.NewNoteUseCase(noteRepository: gh<_i102.NoteRepository>()),
    );
    gh.factory<_i532.SaveNoteUseCase>(
      () => _i532.SaveNoteUseCase(noteRepository: gh<_i102.NoteRepository>()),
    );
    gh.factory<_i773.AuthTokenRepository>(
      () => _i44.AuthTokenRepositoryImpl(
        authTokenStorage: gh<_i850.SecureAuthTokenStorage>(),
      ),
    );
    gh.factory<_i470.NotesBloc>(
      () => _i470.NotesBloc(
        getNotesUseCase: gh<_i798.GetNotesUseCase>(),
        deleteNoteUseCase: gh<_i354.DeleteNoteUseCase>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.getPrivateApiDioClient(
        gh<_i856.Fresh<_i178.AuthTokenPair>>(),
      ),
      instanceName: 'privateApiClient',
    );
    gh.factory<_i109.ProductApiV2>(
      () => _i109.ProductApiV2Impl(
        gh<_i361.Dio>(instanceName: 'privateApiClient'),
      ),
      registerFor: {_prod, _dev, _uat, _preprod},
    );
    gh.factory<_i109.ProductApi>(
      () =>
          _i109.ProductApiImpl(gh<_i361.Dio>(instanceName: 'privateApiClient')),
      registerFor: {_prod, _dev, _uat, _preprod},
    );
    gh.factory<_i191.UserSessionRepository>(
      () => _i723.UserSessionRepositoryImpl(
        secureUserStorage: gh<_i275.SecureUserStorage>(),
      ),
    );
    gh.factory<_i807.LocalizationRepository>(
      () => _i533.LocalizationRepositoryImpl(
        api: gh<_i727.RemoteLocalizationApi>(),
        local: gh<_i808.LocalLocalizationDatasource>(),
        cache: gh<_i195.LocalizationCacheManager>(),
      ),
    );
    gh.factory<_i557.MockRepository>(
      () => _i665.MockRepositoryImpl(mockApi: gh<_i362.MockApiInterface>()),
    );
    gh.factory<_i556.RequestUseCase>(
      () => _i556.RequestUseCase(mockRepository: gh<_i557.MockRepository>()),
    );
    gh.factory<_i168.NoteFormBloc>(
      () => _i168.NoteFormBloc(
        getNoteUseCase: gh<_i21.GetNoteUseCase>(),
        newNoteUseCase: gh<_i894.NewNoteUseCase>(),
        saveNoteUseCase: gh<_i532.SaveNoteUseCase>(),
      ),
    );
    gh.factory<_i157.GetStoredUserProfileUseCase>(
      () =>
          _i157.GetStoredUserProfileUseCase(gh<_i191.UserSessionRepository>()),
    );
    gh.factory<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(
        authRepository: gh<_i787.AuthRepository>(),
        authTokenRepository: gh<_i773.AuthTokenRepository>(),
        userSessionRepository: gh<_i191.UserSessionRepository>(),
      ),
    );
    gh.factory<_i698.LogoutUseCase>(
      () => _i698.LogoutUseCase(
        authRepository: gh<_i787.AuthRepository>(),
        authTokenRepository: gh<_i773.AuthTokenRepository>(),
        userSessionRepository: gh<_i191.UserSessionRepository>(),
      ),
    );
    gh.factory<_i39.ProductRepository>(
      () => _i1040.ProductRepositoryImpl(productApi: gh<_i109.ProductApi>()),
    );
    gh.factory<_i737.NotificationApi>(
      () => _i737.NotificationApiImpl(
        gh<_i361.Dio>(instanceName: 'privateApiClient'),
      ),
      registerFor: {_prod, _dev, _uat, _preprod},
    );
    gh.factory<_i755.GetTranslationUsecase>(
      () => _i755.GetTranslationUsecase(gh<_i807.LocalizationRepository>()),
    );
    gh.lazySingleton<_i219.LocalizationService>(
      () => _i219.LocalizationService(
        gh<_i755.GetTranslationUsecase>(),
        gh<_i195.LocalizationCacheManager>(),
      ),
    );
    gh.lazySingleton<_i85.AuthBloc>(
      () => _i85.AuthBloc(
        loginUseCase: gh<_i1038.LoginUseCase>(),
        logoutUseCase: gh<_i698.LogoutUseCase>(),
      ),
    );
    gh.factory<_i36.ProfileCubit>(
      () => _i36.ProfileCubit(gh<_i157.GetStoredUserProfileUseCase>()),
    );
    gh.factory<_i478.RemoteNotificationRepository>(
      () => _i120.RemoteNotificationRepositoryImpl(
        notificationApi: gh<_i737.NotificationApi>(),
      ),
    );
    gh.factory<_i247.GetProductUseCase>(
      () => _i247.GetProductUseCase(
        productRepository: gh<_i39.ProductRepository>(),
      ),
    );
    gh.factory<_i936.GetProductsUseCase>(
      () => _i936.GetProductsUseCase(
        productRepository: gh<_i39.ProductRepository>(),
      ),
    );
    gh.factory<_i529.SearchProductsUseCase>(
      () => _i529.SearchProductsUseCase(
        productRepository: gh<_i39.ProductRepository>(),
      ),
    );
    gh.factory<_i0.MockBloc>(
      () => _i0.MockBloc(requestUseCase: gh<_i556.RequestUseCase>()),
    );
    gh.singleton<_i630.AppRouter>(() => _i630.AppRouter(gh<_i85.AuthBloc>()));
    gh.factory<_i9.ProductsBloc>(
      () => _i9.ProductsBloc(
        gh<_i936.GetProductsUseCase>(),
        gh<_i529.SearchProductsUseCase>(),
      ),
    );
    gh.factory<_i1052.ProductDetailBloc>(
      () => _i1052.ProductDetailBloc(gh<_i247.GetProductUseCase>()),
    );
    gh.factory<_i571.GetNotificationsUseCase>(
      () => _i571.GetNotificationsUseCase(
        remoteNotificationRepository: gh<_i478.RemoteNotificationRepository>(),
      ),
    );
    gh.factory<_i65.NotificationsBloc>(
      () => _i65.NotificationsBloc(gh<_i571.GetNotificationsUseCase>()),
    );
    return this;
  }
}

class _$HiveModule extends _i105.HiveModule {}

class _$StorageModule extends _i105.StorageModule {}

class _$DioModule extends _i614.DioModule {}

class _$RefreshTokenInterceptorModule
    extends _i767.RefreshTokenInterceptorModule {}

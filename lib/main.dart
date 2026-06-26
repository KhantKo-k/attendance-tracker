import 'dart:async';

import 'package:app_starter_kit_bloc/app.dart';
import 'package:app_starter_kit_bloc/core/configurations/env_config.dart';
import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/error/error_reporter.dart';
import 'package:app_starter_kit_bloc/core/firebase/fcm_service.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/user_session_repository.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/services/localization_service.dart';
import 'package:app_starter_kit_bloc/flavors.dart';
import 'package:app_starter_kit_bloc/core/logging/app_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './firebase_options_dev.dart' as dev;
import './firebase_options_mock.dart' as mock;
import './firebase_options_preprod.dart' as preprod;
import './firebase_options_prod.dart' as prod;
import './firebase_options_uat.dart' as uat;

void main() async {
  runZonedGuarded(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      await _initFirebase();

      // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
      //   !kDebugMode,
      // );

      await _initFirebaseCrashlytics();

      _initErrorCallbackHandler();

      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      _initAppFlavor();

      _initEnvConfig();

      await configureDependencies();

      await _restorePersistedAuthSession();

      await serviceLocator.get<LocalizationService>().initialize();

      // Simulate app loading time
      // await Future.delayed(const Duration(seconds: 2));
      await _initFcmService();

      FlutterNativeSplash.remove();

      // await dotenv.load(fileName: ".env");

      // await initHiveForFlutter();

      // initServiceLocator();

      runApp(const App());
      unawaited(FcmService().requestPermission());
    },
    (error, stackTrace) {
      ErrorReporter().reportException(error, stackTrace);
    },
  );
}

void _initEnvConfig() {
  EnvConfig().init();
}

void _initAppFlavor() {
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );
}

Future<void> _restorePersistedAuthSession() async {
  final result = await serviceLocator.get<UserSessionRepository>().readUser();
  result.fold(
    (user) {
      if (user != null) {
        serviceLocator.get<AuthBloc>().add(
          AuthenticatedUserRestored(user: user),
        );
      }
    },
    (failure) {
      ErrorReporter().reportException(
        failure.exception,
        StackTrace.current,
      );
    },
  );
}

void _initErrorCallbackHandler() {
  FlutterError.onError = (FlutterErrorDetails details) {
    AppLogger().error(
      "At: ${details.context} \n Summary: \n${details.summary} \n Details: \n$details",
    );

    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordFlutterError(details);
    }
  };
}

Future<void> _initFirebase() async {
  final firebaseOptions = switch (appFlavor) {
    'prod' => prod.DefaultFirebaseOptions.currentPlatform,
    'uat' => uat.DefaultFirebaseOptions.currentPlatform,
    'dev' => dev.DefaultFirebaseOptions.currentPlatform,
    'mock' => mock.DefaultFirebaseOptions.currentPlatform,
    'preprod' => preprod.DefaultFirebaseOptions.currentPlatform,
    _ => throw UnsupportedError('Invalid flavor: $appFlavor'),
  };
  await Firebase.initializeApp(options: firebaseOptions);
}

Future<void> _initFirebaseCrashlytics() async {
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
    !kDebugMode,
  );
  FlutterError.onError = (FlutterErrorDetails details) {
    ErrorReporter().reportException(details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    ErrorReporter().reportException(error, stack);
    return true;
  };
}

Future<void> _initFcmService() async {
  final fcmService = FcmService();
  await fcmService.init();
}
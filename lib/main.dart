import 'dart:async';

import 'package:app_starter_kit_bloc/app.dart';
import 'package:app_starter_kit_bloc/core/configurations/env_config.dart';
import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/error/error_reporter.dart';
import 'package:app_starter_kit_bloc/core/firebase/fcm_service.dart';
import 'package:app_starter_kit_bloc/core/services/connectivity_service.dart';
import 'package:app_starter_kit_bloc/features/attendance/domain/use_cases/attendance_use_cases.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/services/localization_service.dart';
import 'package:app_starter_kit_bloc/flavors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './firebase_options_local.dart' as local;
import './firebase_options_production.dart' as production;
import './firebase_options_staging.dart' as staging;

void main() async {
  runZonedGuarded(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      await _initFirebase();

      await _initFirebaseCrashlytics();

      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      _initAppFlavor();

      _initEnvConfig();

      await configureDependencies();

      await _configureFirestore();

      _listenForConnectivitySync();

      await serviceLocator.get<LocalizationService>().initialize();


      await _initFcmService();

      FlutterNativeSplash.remove();
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

Future<void> _configureFirestore() async {
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
}

void _listenForConnectivitySync() {
  final connectivityService = serviceLocator.get<ConnectivityService>();
  final syncUseCase = serviceLocator.get<SyncPendingAttendanceUseCase>();

  connectivityService.onConnectivityChanged.listen((isOnline) async {
    if (!isOnline) {
      return;
    }
    await syncUseCase();
  });
}

Future<void> _initFirebase() async {
  final firebaseOptions = switch (appFlavor) {
    'production' => production.DefaultFirebaseOptions.currentPlatform,
    'staging' => staging.DefaultFirebaseOptions.currentPlatform,
    'local' => local.DefaultFirebaseOptions.currentPlatform,
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
import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/core/network/dio_module.dart';
import 'package:app_starter_kit_bloc/core/storage/hive/hive_registrar.g.dart';
import 'package:app_starter_kit_bloc/core/storage/hive/schema.dart';
import 'package:app_starter_kit_bloc/flavors.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'service_locator.config.dart';

part 'service_locator_ext.dart';
part '../storage/hive/hive_module.dart';
part '../storage/storage_module.dart';

final serviceLocator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async =>
    await serviceLocator.init(environment: F.appFlavor.name);

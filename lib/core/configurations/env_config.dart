import 'package:attendance_tracker/core/configurations/base.env.dart';
import 'package:attendance_tracker/core/configurations/local.env.dart';
import 'package:attendance_tracker/core/configurations/production.env.dart';
import 'package:attendance_tracker/core/configurations/staging.env.dart';
import 'package:attendance_tracker/flavors.dart';

class EnvConfig {
  static late final String baseUrl;
  static late final String firebaseUrl;

  void init() {
    final env = getEnv();

    baseUrl = env.mBaseUrl;
    firebaseUrl = env.mFirebaseUrl;
  }

  BaseEnv getEnv() => switch (F.appFlavor) {
    Flavor.local => LocalEnv(),
    Flavor.staging => StagingEnv(),
    Flavor.production => ProductionEnv(),
  };
}

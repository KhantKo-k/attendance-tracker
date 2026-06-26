import 'package:app_starter_kit_bloc/core/configurations/base.env.dart';
import 'package:app_starter_kit_bloc/core/configurations/dev.env.dart';
import 'package:app_starter_kit_bloc/core/configurations/mock.env.dart';
import 'package:app_starter_kit_bloc/core/configurations/uat.env.dart';
import 'package:app_starter_kit_bloc/core/configurations/preprod.env.dart';
import 'package:app_starter_kit_bloc/core/configurations/prod.env.dart';
import 'package:app_starter_kit_bloc/flavors.dart';

class EnvConfig {
  static late final String baseUrl;
  static late final String firebaseUrl;
  static late final String watcherMail;
  static late final String debugKey;
  static late final String releaseKey;
  static late final String playSigningKey;
  static late final String androidPackageName;
  static late final String iosBundleId;
  static late final String teamId;
  static late final String testerEmail;
  static late final String testerPassword;
  static late final String publicApiKey;
  static late final String cmsPublicApiKey;
  static late final String cmsBaseUrl;

  void init() {
    final env = getEnv();

    baseUrl = env.mBaseUrl;
    firebaseUrl = env.mFirebaseUrl;
    watcherMail = env.mWatcherMail;
    debugKey = env.mDebugKey;
    releaseKey = env.mReleaseKey;
    playSigningKey = env.mPlaySigningKey;
    androidPackageName = env.mAndroidPackageName;
    iosBundleId = env.mIosBundleId;
    teamId = env.mTeamId;
    testerEmail = env.mTesterEmail;
    testerPassword = env.mTesterPassword;
    publicApiKey = env.mPublicApiKey;
    cmsPublicApiKey = env.mCmsPublicApiKey;
    cmsBaseUrl = env.mCmsBaseUrl;
  }

  BaseEnv getEnv() => switch (F.appFlavor) {
    Flavor.mock => MockEnv(),
    Flavor.dev => DevEnv(),
    Flavor.uat => UatEnv(),
    Flavor.preprod => PreprodEnv(),
    Flavor.prod => ProdEnv(),
  };
}

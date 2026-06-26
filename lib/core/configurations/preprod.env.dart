import 'package:app_starter_kit_bloc/core/configurations/base.env.dart';
import 'package:envied/envied.dart';

part 'preprod.env.g.dart';

@Envied(path: '.env.preprod')
interface class PreprodEnv implements BaseEnv {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _PreprodEnv.baseUrl;

  @EnviedField(varName: 'FIREBASE_URL')
  static const String firebaseUrl = _PreprodEnv.firebaseUrl;

  @EnviedField(varName: 'WATCHER_MAIL')
  static const String watcherMail = _PreprodEnv.watcherMail;

  @EnviedField(varName: 'DEBUG_KEY')
  static const String debugKey = _PreprodEnv.debugKey;

  @EnviedField(varName: 'RELEASE_KEY')
  static const String releaseKey = _PreprodEnv.releaseKey;

  @EnviedField(varName: 'PLAY_SIGNING_KEY')
  static const String playSigningKey = _PreprodEnv.playSigningKey;

  @EnviedField(varName: 'ANDROID_PACKAGE_NAME')
  static const String androidPackageName = _PreprodEnv.androidPackageName;

  @EnviedField(varName: 'IOS_BUNDLE_ID')
  static const String iosBundleId = _PreprodEnv.iosBundleId;

  @EnviedField(varName: 'TEAM_ID')
  static const String teamId = _PreprodEnv.teamId;

  @EnviedField(varName: 'TESTER_EMAIL')
  static const String testerEmail = _PreprodEnv.testerEmail;

  @EnviedField(varName: 'TESTER_PASSWORD', obfuscate: true)
  static final String testerPassword = _PreprodEnv.testerPassword;

  @EnviedField(varName: 'PUBLIC_API_KEY', obfuscate: true)
  static final String publicApiKey = _PreprodEnv.publicApiKey;

  @EnviedField(varName: 'CMS_PUBLIC_API_KEY', obfuscate: true)
  static final String cmsPublicApiKey = _PreprodEnv.cmsPublicApiKey;

  @EnviedField(varName: 'CMS_BASE_URL')
  static const String cmsBaseUrl = _PreprodEnv.cmsBaseUrl;

  @override
  String get mBaseUrl => baseUrl;

  @override
  String get mFirebaseUrl => firebaseUrl;

  @override
  String get mWatcherMail => watcherMail;

  @override
  String get mDebugKey => debugKey;

  @override
  String get mReleaseKey => releaseKey;

  @override
  String get mPlaySigningKey => playSigningKey;

  @override
  String get mAndroidPackageName => androidPackageName;

  @override
  String get mIosBundleId => iosBundleId;

  @override
  String get mTeamId => teamId;

  @override
  String get mTesterEmail => testerEmail;

  @override
  String get mTesterPassword => testerPassword;

  @override
  String get mPublicApiKey => publicApiKey;

  @override
  String get mCmsPublicApiKey => cmsPublicApiKey;

  @override
  String get mCmsBaseUrl => cmsBaseUrl;
}

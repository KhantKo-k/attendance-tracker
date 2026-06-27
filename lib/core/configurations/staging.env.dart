import 'package:app_starter_kit_bloc/core/configurations/base.env.dart';
import 'package:envied/envied.dart';

part 'staging.env.g.dart';

@Envied(path: '.env.staging')
interface class StagingEnv implements BaseEnv {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _StagingEnv.baseUrl;

  @EnviedField(varName: 'FIREBASE_URL')
  static const String firebaseUrl = _StagingEnv.firebaseUrl;

  @EnviedField(varName: 'WATCHER_MAIL')
  static const String watcherMail = _StagingEnv.watcherMail;

  @EnviedField(varName: 'DEBUG_KEY')
  static const String debugKey = _StagingEnv.debugKey;

  @EnviedField(varName: 'RELEASE_KEY')
  static const String releaseKey = _StagingEnv.releaseKey;

  @EnviedField(varName: 'PLAY_SIGNING_KEY')
  static const String playSigningKey = _StagingEnv.playSigningKey;

  @EnviedField(varName: 'ANDROID_PACKAGE_NAME')
  static const String androidPackageName = _StagingEnv.androidPackageName;

  @EnviedField(varName: 'IOS_BUNDLE_ID')
  static const String iosBundleId = _StagingEnv.iosBundleId;

  @EnviedField(varName: 'TEAM_ID')
  static const String teamId = _StagingEnv.teamId;

  @EnviedField(varName: 'TESTER_EMAIL')
  static const String testerEmail = _StagingEnv.testerEmail;

  @EnviedField(varName: 'TESTER_PASSWORD', obfuscate: true)
  static final String testerPassword = _StagingEnv.testerPassword;

  @EnviedField(varName: 'PUBLIC_API_KEY', obfuscate: true)
  static final String publicApiKey = _StagingEnv.publicApiKey;

  @EnviedField(varName: 'CMS_PUBLIC_API_KEY', obfuscate: true)
  static final String cmsPublicApiKey = _StagingEnv.cmsPublicApiKey;

  @EnviedField(varName: 'CMS_BASE_URL')
  static const String cmsBaseUrl = _StagingEnv.cmsBaseUrl;

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

import 'package:attendance_tracker/core/configurations/base.env.dart';
import 'package:envied/envied.dart';

part 'staging.env.g.dart';

@Envied(path: '.env.staging')
interface class StagingEnv implements BaseEnv {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _StagingEnv.baseUrl;

  @EnviedField(varName: 'FIREBASE_URL')
  static const String firebaseUrl = _StagingEnv.firebaseUrl;

  @override
  String get mBaseUrl => baseUrl;

  @override
  String get mFirebaseUrl => firebaseUrl;
}

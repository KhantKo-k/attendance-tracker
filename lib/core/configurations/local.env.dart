import 'package:attendance_tracker/core/configurations/base.env.dart';
import 'package:envied/envied.dart';

part 'local.env.g.dart';

@Envied(path: '.env.local')
interface class LocalEnv implements BaseEnv {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _LocalEnv.baseUrl;

  @EnviedField(varName: 'FIREBASE_URL')
  static const String firebaseUrl = _LocalEnv.firebaseUrl;

  @override
  String get mBaseUrl => baseUrl;

  @override
  String get mFirebaseUrl => firebaseUrl;
}

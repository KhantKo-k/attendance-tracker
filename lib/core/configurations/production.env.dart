import 'package:attendance_tracker/core/configurations/base.env.dart';
import 'package:envied/envied.dart';

part 'production.env.g.dart';

@Envied(path: '.env.production')
interface class ProductionEnv implements BaseEnv {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _ProductionEnv.baseUrl;

  @EnviedField(varName: 'FIREBASE_URL')
  static const String firebaseUrl = _ProductionEnv.firebaseUrl;

  @override
  String get mBaseUrl => baseUrl;

  @override
  String get mFirebaseUrl => firebaseUrl;
}

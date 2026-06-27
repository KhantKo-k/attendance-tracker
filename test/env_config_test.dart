import 'package:attendance_tracker/core/configurations/env_config.dart';
import 'package:attendance_tracker/flavors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('EnvConfig exposes local flavor values', () {
    F.appFlavor = Flavor.local;
    EnvConfig().init();

    expect(EnvConfig.baseUrl, 'https://dummyjson.com');
    expect(
      EnvConfig.firebaseUrl,
      'https://movie-ticket-app-5123f.web.app',
    );
  });
}

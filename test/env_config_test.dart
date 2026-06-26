import 'package:app_starter_kit_bloc/core/configurations/env_config.dart';
import 'package:app_starter_kit_bloc/flavors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('EnvConfig exposes tester email and deobfuscated tester password', () {
    F.appFlavor = Flavor.mock;
    EnvConfig().init();

    expect(EnvConfig.testerEmail, 'mock_tester@example.test');
    expect(EnvConfig.testerPassword, 'MockPass1');
    expect(EnvConfig.publicApiKey, 'mock_public_api_key');
    expect(EnvConfig.cmsPublicApiKey, 'mock_cms_public_api_key');
    expect(EnvConfig.cmsBaseUrl, 'https://cms.example.test');
  });
}

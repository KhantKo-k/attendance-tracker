part of 'service_locator.dart';

extension ServiceLocatorExtension on GetIt {
  Dio getPrivateApiClient() => get<Dio>(instanceName: privateApiClientKey);
  Dio getPublicApiClient() => get<Dio>(instanceName: publicApiClientKey);
  AppRouter getAppRouter() => get<AppRouter>();
}

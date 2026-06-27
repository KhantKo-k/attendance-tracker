part of 'service_locator.dart';

extension ServiceLocatorExtension on GetIt {
  Dio getPublicApiClient() => get<Dio>(instanceName: publicApiClientKey);
  AppRouter getAppRouter() => get<AppRouter>();
}

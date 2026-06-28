enum Flavor {
  local,
  staging,
  production,
}

/// Set at build time via `--dart-define=appFlavor=<flavor>`.
/// Must match the `--flavor` passed to `flutter run` / `flutter build`.
const String appFlavor = String.fromEnvironment(
  'appFlavor',
  defaultValue: 'local',
);

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.local:
        return 'Attendance Tracker (Local)';
      case Flavor.staging:
        return 'Attendance Tracker (Staging)';
      case Flavor.production:
        return 'Attendance Tracker (Production)';
    }
  }
}

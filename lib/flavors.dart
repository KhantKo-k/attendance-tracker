enum Flavor {
  mock,
  dev,
  uat,
  preprod,
  prod,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.mock:
        return 'App Starter Kit (Mock)';
      case Flavor.dev:
        return 'App Starter Kit (Dev)';
      case Flavor.uat:
        return 'App Starter Kit (UAT)';
      case Flavor.preprod:
        return 'App Starter Kit (Preprod)';
      case Flavor.prod:
        return 'App Starter Kit (Prod)';
    }
  }

}

# Flutter App Starter Kit

A starter project for a Flutter application. It includes a foundation for a Flutter application with flavors.

## Features

**Core**

- [x] Clean architecture (data, domain, presentation)
- [x] Localization
- [x] Theme
- [x] Splash Generation
- [x] Environment variables
- [x] Dependency injection
- [x] Navigation
- [x] State management (Bloc)
- [x] Repository pattern
- [ ] Local cache
- [x] API client
- [x] Data classes
- [x] Logging
- [x] Error handling
- [x] Refresh token handling
- [x] Error reporting
- [x] App Security Checks
- [x] Push Notifications
- [x] Deep Links

**Third Party**

- [x] Firebase init
- [x] Firebase Crashlytics

**Distribution**

- [x] Signing keys
- [x] Flavors
- [x] Build scripts
- [x] API Keys Management

**Agents**

- [ ] AGENTS.md
- [ ] Rules
   - [ ] Architecture
- [ ] Skills
   - [ ] State management
   - [ ] Dependency Injection
   - [ ] Error Handling
   - [ ] Logging
   - [ ] Navigation
   - [ ] Feature Implementation
- [ ] PRD
- [ ] Mobile MCP
- [ ] Figma to Implementation
- [ ] SDD  (Spec Driven Development)

## Libraries Used

- **Bloc**: for state management
- **Go Router**: for navigation
- **Dio**: for HTTP requests
- **Fresh Dio**: for refresh token handling
- **Retrofit**: for API requests
- **Dartz**: for functional programming
- **Get It**: for dependency injection
- **Injectable**: for dependency configuration
- **Freezed**: for data classes
- **Json Serializable**: for JSON serialization
- **Equatable**: for equality comparison
- **Logger**: for logging
- **Flutter Secure Storage**: for secure storage
- **Flutter Flavorizr**: for flavor configuration

# Getting Started

## Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio
- Xcode

## Installation

1. Clone the repository
2. Run `flutter pub get` to install the dependencies
3. Run `dart run build_runner build` to generate the necessary files
4. See the `launch.json` file for the available launch configurations

## Removing unnecessary platforms

If you are not developing for `web`, `linux`, `windows`, or `macos`, you can remove the unnecessary platforms folders.

## Step 1: Configure App Signing (For Android)

Before starting the development process, you need to configure the app signing for your app. To do this, follow the steps below:

1. Create a new file called `key.properties` in the `android` folder
2. Copy the content of the `key.properties.example` file to the `key.properties` file
3. Edit the `key.properties` file to add the correct values for your app
4. If you don't have the keystore files, you can generate them using the instructions in the `docs/keytool-commands.md` file.

## Step 2: Flavoring App Using Flutter Flavorizr

To change package ids and configure flavors, follow the steps below:

1. Edit the `pubspec.yaml` file to change the package id and the app name under the `flavorizr` section
2. See the official documentation for more details [here](https://pub.dev/packages/flutter_flavorizr)
3. Run the following command to generate the necessary configuration

```bash
dart run flutter_flavorizr
```

4. As this example doesn't do the generation of the app icons and launch screen, you need to manually change some ios configurations after flavorization.
   - **Launch Screen**: In xcode, open `Info` tab inside the target `Runner`, and change the `Launch screen interface file base name` to `LaunchScreen`.
   - **App Icon**: In xcode, open `Build Settings` tab inside the project `Runner`, type `icon` in the filter box, and change the `Primary App Icon Set Name` to `AppIcon`.

**Note:** Flutter flavorizr only works for Android, iOS and MacOS.

## Step 3: Firebase Setup

After configuring the app signing keys and flavors, you need to configure Firebase. To do this, follow the steps below:

1. Add your debug and release SHA256 fingerprints to the Firebase console for all flavors.
2. Download the `google-services.json` and `GoogleService-Info.plist` files for each flavor and place it in the `.firebase/<flavor>/` folder.
4. Run `./flutterfire-config.sh ${flavor}` to generate the necessary files for the flavor.
   - After choosing desire platforms, choose `Build configuration` and then select the `Debug-${flavor}` configuration.


**Documentations:** You can see the documentation about `flutterfire documentation` [here](https://firebase.google.com/docs/flutter/setup) and `flutterfire shell script` [here](https://codewithandrea.com/articles/flutter-firebase-multiple-flavors-flutterfire-cli/).

**Note:** This starter project uses single firebase project for all flavors. You must create projects for each flavor in the Firebase Console and run `flutterfire configure` to generate the necessary files for each flavor. You can see the detail example [here](https://codewithandrea.com/articles/flutter-firebase-multiple-flavors-flutterfire-cli/)

## Step 4: Generating Splash Screens

1. Edit the configuration in `flutter_native_splash.yaml`, see the docs [here](https://pub.dev/packages/flutter_native_splash)
2. Run the following command to generate the splash screen

```bash
dart run flutter_native_splash:create --path=flutter_native_splash.yaml
```

3. (Optional) If you want to preserve the splash screen during app initialization, move the `flutter_native_splash` from dev dependencies to dependencies in `pubspec.yaml`.


## Build & Run

### Development Builds

**Android APK**:
```bash
flutter build apk --flavor local --dart-define=appFlavor=local
```

**iOS**:
```bash
flutter build ios --flavor local --dart-define=appFlavor=local
```

### Production Builds

The project includes build scripts for production builds with automatic symbol upload:

**Android**:
```bash
# Build APK
./build-apk-upload-symbols.sh apk production

# Build App Bundle (for Play Store)
./build-apk-upload-symbols.sh appbundle production
```

**iOS**:
```bash
./build-ipa-upload-symbols.sh production
```

These scripts will:
1. Build the app in release mode with obfuscation
2. Generate debug symbols
3. Upload symbols to Firebase Crashlytics

For detailed build instructions, see [BUILD_SCRIPTS.md](./BUILD_SCRIPTS.md).
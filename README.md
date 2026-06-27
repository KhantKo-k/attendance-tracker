# Attendance Tracker

Role-based attendance app built with Flutter, BLoC, and Firebase. Users check in/out with location; admins view a dashboard, user list, and attendance history. Supports **local**, **staging**, and **production** flavors.

## Features

- Email/password auth (register, login, logout)
- User check-in / check-out with GPS location
- Offline attendance queue with sync when back online
- Admin dashboard, user search, and per-user history
- English / Myanmar localization and light / dark theme
- Firebase Auth, Firestore, and Crashlytics

## Prerequisites

| Tool | Purpose |
|------|---------|
| [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable) | Build and run the app |
| Android Studio + SDK | Android emulator / device |
| Xcode (macOS only) | iOS simulator / device |
| [Firebase CLI](https://firebase.google.com/docs/cli) | Deploy Firestore rules |

Optional: CocoaPods (`sudo gem install cocoapods`) for iOS.

---

## Run the project (step by step)

### 1. Clone and install dependencies

```bash
git clone <repository-url>
cd attendance_tracker
flutter pub get
```

### 2. Create environment files

Env files are **not** committed (see `.gitignore`). Create one file per flavor at the repo root:

- `.env.local`
- `.env.staging`
- `.env.production`

Each file only needs these two keys:

```env
BASE_URL=https://example.com
FIREBASE_URL=https://attendance-tracker-d696e.firebaseio.com
```

### 3. Generate code

Run after cloning or whenever you change env files, Freezed models, or injectable classes:

```bash
dart run build_runner clean
dart run build_runner build
```

This generates `*.g.dart`, `*.freezed.dart`, envied config, and DI setup.

### 4. Configure Android signing

Debug and release builds expect `android/key.properties`.

```bash
cp android/key.properties.example android/key.properties
```

Edit `android/key.properties` with your keystore paths and passwords.  
To generate keystores, see [`.docs/keytool-commands.md`](.docs/keytool-commands.md).

> Without `key.properties`, Android builds will fail.

### 5. Set up Firebase

**Firebase project (local dev):** `attendance-tracker-d696e`

#### 5a. Enable Firebase services

In [Firebase Console](https://console.firebase.google.com/project/attendance-tracker-d696e):

1. **Authentication** → Sign-in method → enable **Email/Password**
2. **Firestore Database** → Create database (production mode is fine; rules come from the repo)

#### 5b. Add Android / iOS apps

Register an app for each flavor you use. Package / bundle IDs:

| Flavor | Android applicationId | iOS bundle ID |
|--------|----------------------|---------------|
| local | `com.kkz.attendance_tracker.local` | `com.kkz.attendance-tracker.local` |
| staging | `com.kkz.attendance_tracker.staging` | `com.kkz.attendance-tracker.staging` |
| production | `com.kkz.attendance_tracker.production` | `com.kkz.attendance-tracker.production` |

Download config files and place them here (also copied by the script in 5c):

```
android/app/src/local/google-services.json
android/app/src/staging/google-services.json
android/app/src/production/google-services.json

ios/Runner/local/GoogleService-Info.plist
ios/Runner/staging/GoogleService-Info.plist
ios/Runner/production/GoogleService-Info.plist
```

Add your debug **SHA-1 / SHA-256** fingerprints in Firebase Console for each Android app.

#### 5c. Generate FlutterFire options (optional refresh)

```bash
chmod +x flutterfire-config.sh
./flutterfire-config.sh local
```

Repeat for `staging` or `production` if needed. This updates `lib/firebase_options_<flavor>.dart` and the native config paths above.

#### 5d. Deploy Firestore security rules

**Required** for admin access to users and attendance logs. Rules live in [`firestore.rules`](firestore.rules) and read admin role from the Firestore `users` document (not from the auth token).

```bash
firebase login
firebase use attendance-tracker-d696e
firebase deploy --only firestore:rules
```

Do **not** use `request.auth.token.role` in console rules unless you set custom claims via the Admin SDK. The repo rules use `users/{uid}.role == 'admin'`.

#### 5e. Create an admin user

1. Register a user in the app (or create one in Firebase Authentication).
2. In Firestore → `users` → `{uid}`, set:

```json
{
  "name": "Admin",
  "email": "admin@example.com",
  "role": "admin"
}
```

Regular users must have `"role": "user"` (set automatically on register).

### 6. iOS setup (macOS only)

```bash
cd ios
pod install
cd ..
```

Open `ios/Runner.xcworkspace` in Xcode if you need to fix signing team / provisioning.

### 7. Run the app

**VS Code / Cursor:** use a launch config from [`.vscode/launch.json`](.vscode/launch.json), e.g. **Attendance Tracker Local (debug)**.

**CLI:**

```bash
flutter run --flavor local --dart-define=appFlavor=local
```

Both `--flavor` and `--dart-define=appFlavor=...` are required and must match.

---

## Flavors

| Flavor | Use case | `appFlavor` value |
|--------|----------|-------------------|
| local | Local development | `local` |
| staging | Pre-production testing | `staging` |
| production | Store / production | `production` |

Env file mapping: `.env.local` → `local`, `.env.staging` → `staging`, `.env.production` → `production`.

---

## Build commands

### Debug / development

```bash
# Android
flutter run --flavor local --dart-define=appFlavor=local
flutter build apk --flavor local --dart-define=appFlavor=local

# iOS
flutter run --flavor local --dart-define=appFlavor=local
flutter build ios --flavor local --dart-define=appFlavor=local
```

### Release (with Crashlytics symbols)

```bash
# Android APK
./build-apk-upload-symbols.sh apk local

# Android App Bundle
./build-apk-upload-symbols.sh appbundle production

# iOS IPA
./build-ipa-upload-symbols.sh production
```

---

## Firebase deploy quick reference

```bash
firebase use attendance-tracker-d696e
firebase deploy --only firestore:rules
```

---

## Troubleshooting

| Issue | What to check |
|-------|----------------|
| Admin **Forbidden** on Users page | Deploy [`firestore.rules`](firestore.rules). Admin doc must have `role: "admin"`. |
| Build fails on env / code gen | Run `dart run build_runner build`. Ensure `.env.<flavor>` exists with `BASE_URL` and `FIREBASE_URL`. |
| Android signing error | Create `android/key.properties` from the example file. |

---

## Project structure

See [`AGENTS.md`](AGENTS.md) for architecture, coding standards, and folder layout.

## Libraries

Bloc, go_router, Dio, Retrofit, Freezed, injectable / GetIt, Dartz, envied, Firebase (Auth, Firestore, Crashlytics), Hive CE, geolocator, connectivity_plus.

---

## Optional: flavorizr / splash

Only needed when changing app IDs or flavor setup:

```bash
dart run flutter_flavorizr
```

Regenerate splash screens:

```bash
dart run flutter_native_splash:create --path=flutter_native_splash.yaml
```

import 'package:app_starter_kit_bloc/core/configurations/env_config.dart';
import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/security/bloc/app_security_guard_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freerasp/freerasp.dart';


enum AppSecurityIssue {
  /// Every application can be easily modified and then resigned by an attacker.
  /// This process is known as application repackaging. There may be many
  /// reasons for application repackaging, whether it's adding new code,
  /// removing app protections, or bypassing app licensing. A modified/tampered
  /// application is often distributed using third-party stores or other side channels.
  ///
  ///
  /// Talsec uses various checks to detect whether the application was tampered
  /// (e.g., changed package name, signing hash).
  appIntegrity,

  /// While most developers use debuggers to trace the flow of their program
  /// during its execution same tool can be attached to an application in an attempt
  /// to reverse engineer, check memory values, and steal confidential information.
  /// This method looks for specific flags to determine whether the debugger is active
  /// and offers the option to disable it.
  debug,

  /// Device binding is attaching an application instance to a particular mobile
  /// device. This method detects a transfer of an application instance to another
  /// device. A new install of the application (e.g. in case of buying a new device
  /// and transfer the apps) is not detected.
  deviceBinding,

  /// The deviceID detects, whether the device identifier has been changed. It is
  /// triggered after reinstallation of the application if there are no other applications
  /// from the same vendor installed. The value can also change when installing test
  /// builds using Xcode or when installing an app on a device using ad-hoc distribution.
  deviceId,

  /// The application can be analysed or modified even though its source code has
  /// not been changed, applying a technique known as hooking. This technique can
  /// be used to intercept system or application calls and then modify them. An
  /// attacker can exploit this by inserting new (often malicious) code or by altering
  /// existing one to obtain personal client data. The most well-known hooking frameworks
  /// are Frida, Xposed, or Cydia Substrate.
  hooks,

  /// Rooting/jailbreaking is a technique of acquiring privileged control over the
  /// operating system of an Android/iOS device. While most users root their devices
  /// to overcome the limitations put on the devices by the manufacturers, it also
  /// enables those with malicious intent to abuse privileged access and steal sensitive
  /// information. Many different attack vectors require privileged access to be performed.
  /// Tools such as Magisk, Shad0w or Dopamine can hide privileged access and are
  /// often used by attackers.
  privilegedAccess,

  /// The Secure Enclave and the Android Keystore system make it very difficult
  /// to decrypt sensitive data without physical access to the device. In that order,
  /// these keys need to be stored securely. freeRASP checks if the keys reside
  /// inside secure hardware.
  secureHardwareNotAvailable,

  /// Users can share a copy of the application on unofficial stores or various
  /// pirate forums. While some users download these copies to avoid paying for
  /// the product, they can include unknown and possibly dangerous modifications.
  /// Verifying an official installation consequently protects both the users and
  /// the owner. This reaction is also triggered, if you install the application
  /// through alternative ways like unofficial store or Xcode build.
  unofficialStore,
}

class TalsecService {
  static void initTalsecThreatDetection() {
    Talsec.instance.attachListener(_buildThreatCallback());
  }

  static void startTalsecThreatDetection() {
    final config = _buildConfig();

    Talsec.instance.start(config);
  }

  static TalsecConfig _buildConfig() {
    return TalsecConfig(
      watcherMail: EnvConfig.watcherMail,
      androidConfig: _buildAndroidConfig(),
      iosConfig: _buildIOSConfig(),
      // isProd: kReleaseMode,
    );
  }

  static AndroidConfig _buildAndroidConfig() {
    return AndroidConfig(
      packageName: EnvConfig.androidPackageName,
      signingCertHashes: [
        EnvConfig.debugKey,
        EnvConfig.releaseKey,
        EnvConfig.playSigningKey,
      ],
    );
  }

  static IOSConfig _buildIOSConfig() {
    return IOSConfig(
      bundleIds: [EnvConfig.iosBundleId],
      teamId: EnvConfig.teamId,
    );
  }

  static ThreatCallback _buildThreatCallback() {
    return ThreatCallback(
      onAppIntegrity: () => _onAppSecurityIssue(AppSecurityIssue.appIntegrity),
      // onDebug: () => _onAppSecurityIssue(AppSecurityIssue.debug),
      // onDeviceBinding: () =>
      //     _onAppSecurityIssue(AppSecurityIssue.deviceBinding),
      // onDeviceID: () => _onAppSecurityIssue(AppSecurityIssue.deviceId),
      onHooks: () => _onAppSecurityIssue(AppSecurityIssue.hooks),
      onPrivilegedAccess: () =>
          _onAppSecurityIssue(AppSecurityIssue.privilegedAccess),
      // onSecureHardwareNotAvailable: () =>
      //     _onAppSecurityIssue(AppSecurityIssue.secureHardwareNotAvailable),
      // onUnofficialStore: () =>
      //     _onAppSecurityIssue(AppSecurityIssue.unofficialStore),
    );
  }

  static void _onAppSecurityIssue(AppSecurityIssue issue) {
    if (kDebugMode) {
      return;
    }

    final event = AppSecurityIssueDetected(issue: issue);

    serviceLocator<AppSecurityGuardBloc>().add(event);
  }
}

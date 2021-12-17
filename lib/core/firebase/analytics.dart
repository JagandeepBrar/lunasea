import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseAnalytics {
  /// Returns true if Firebase Analytics is compatible with this build system/platform.
  static bool get isPlatformCompatible {
    return LunaFirebase.isPlatformCompatible &&
        !Platform.isLinux &&
        !Platform.isMacOS &&
        !Platform.isWindows;
  }

  /// Returns an instance of [FirebaseAnalytics].
  ///
  /// Throws an error if [LunaFirebase.initialize] has not been called.
  static FirebaseAnalytics get instance => FirebaseAnalytics.instance;

  /// Returns an instance of [FirebaseAnalyticsObserver].
  ///
  /// Throws an error if [LunaFirebase.initialize] has not been called.
  static FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: instance);

  /// Set the enabled state of Firebase Analytics.
  ///
  /// If `enabled` is set to false, force-disables Analytics.
  void setEnabledState() {
    if (isPlatformCompatible) {
      bool state = LunaDatabaseValue.ENABLE_FIREBASE_ANALYTICS.data;
      instance.setAnalyticsCollectionEnabled(state);
    }
  }

  /// Log an "app_open" event.
  Future<void> appOpened() async {
    if (isPlatformCompatible) instance.logAppOpen();
  }
}

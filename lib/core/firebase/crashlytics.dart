import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseCrashlytics {
    /// Returns true if Firebase Analytics is compatible with this build system/platform.
    static bool get isPlatformCompatible => !Platform.isLinux && !Platform.isMacOS && !Platform.isWindows;

    /// Returns an instance of [FirebaseCrashlytics].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseCrashlytics get instance => FirebaseCrashlytics.instance;

    /// Set the enabled state of Firebase Crashlytics.
    /// 
    /// If `enabled` is set to false, force-disables Analytics.
    void setEnabledState() {
        if(isPlatformCompatible) {
            bool state = kReleaseMode && LunaDatabaseValue.ENABLE_FIREBASE_CRASHLYTICS.data;
            instance.setCrashlyticsCollectionEnabled(state);
        }
    }
}

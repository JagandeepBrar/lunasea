import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseCrashlytics {
    /// Returns an instance of [FirebaseCrashlytics].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseCrashlytics get instance => FirebaseCrashlytics.instance;

    /// Set the enabled state of Firebase Crashlytics.
    /// 
    /// If `enabled` is supplied, use that value, else use [LunaDatabaseValue.ENABLED_SENTRY].
    void setEnabledState() {
        bool state = LunaDatabaseValue.ENABLED_SENTRY.data;
        instance.setCrashlyticsCollectionEnabled(state);
    }
}

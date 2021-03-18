import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseAnalytics {
    /// Returns an instance of [FirebaseAnalytics].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseAnalytics get instance => FirebaseAnalytics();

    /// Returns an instance of [FirebaseAnalyticsObserver].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseAnalyticsObserver get observer => FirebaseAnalyticsObserver(analytics: instance);

    /// Set the enabled state of Firebase Analytics.
    void setEnabledState() {
        bool state = LunaDatabaseValue.ENABLE_FIREBASE_ANALYTICS.data;
        instance.setAnalyticsCollectionEnabled(state);
    }

    /// Log an "app_open" event.
    Future<void> appOpened() async => instance.logAppOpen();
}

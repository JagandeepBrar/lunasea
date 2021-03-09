import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseAnalytics {
    /// Returns an instance of [FirebaseAnalytics].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseAnalytics get instance => FirebaseAnalytics();
}

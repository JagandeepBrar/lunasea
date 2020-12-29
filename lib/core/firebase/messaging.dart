import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseMessaging {
    /// Returns an instance of [FirebaseMessaging].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseMessaging get instance => FirebaseMessaging.instance;

    /// Request for permission to send a user notifications.
    /// 
    /// Returns true if permissions are allowed at either a full or provisional level.
    /// Returns false if permissions are denied or not determined.
    Future<bool> requestNotificationPermissions() async {
        NotificationSettings settings = await instance.requestPermission();
        switch(settings.authorizationStatus) {
            case AuthorizationStatus.authorized:
            case AuthorizationStatus.provisional: return true;
            case AuthorizationStatus.denied:
            case AuthorizationStatus.notDetermined:
            default: return false;
        }
    }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LunaFirebase {    
    /// Return an instance of [FirebaseApp].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseApp get app => Firebase.app();

    /// Return an instance of [FirebaseAuth].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseAuth get auth => FirebaseAuth.instance;

    /// Returns an instance of [FirebaseMessaging].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseMessaging get messaging => FirebaseMessaging.instance;

    /// Returns an instance of [FirebaseStorage].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseStorage get storage => FirebaseStorage.instance;

    /// Initialize Firebase and configuration.
    /// 
    /// This must be called before anything accesses Firebase services, or an exception will be thrown.
    static Future<void> initialize({ String name }) async => await Firebase.initializeApp();

    Future<bool> requestNotificationPermissions() async {
        NotificationSettings settings = await messaging.requestPermission();
        switch(settings.authorizationStatus) {
            case AuthorizationStatus.authorized:
            case AuthorizationStatus.provisional: return true;
            case AuthorizationStatus.denied:
            case AuthorizationStatus.notDetermined:
            default: return false;
        }
    }
}

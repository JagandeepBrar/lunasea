import 'package:firebase_core/firebase_core.dart';

class LunaFirebase {
    LunaFirebase._();
    
    /// Return an instance of [FirebaseApp].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseApp get app => Firebase.app();

    /// Initialize Firebase: Calls [Firebase.initializeApp()].
    /// 
    /// This must be called before anything accesses Firebase services, or an exception will be thrown.
    static Future<FirebaseApp> initialize({ String name }) async => Firebase.initializeApp();
}

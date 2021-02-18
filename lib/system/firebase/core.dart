import 'package:firebase_core/firebase_core.dart';

class LunaFirebase {
    /// Return an instance of [FirebaseApp].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseApp get instance => Firebase.app();

    /// Initialize Firebase and configuration.
    /// 
    /// This must be called before anything accesses Firebase services, or an exception will be thrown.
    Future<void> initialize({ String name }) async => await Firebase.initializeApp();
}

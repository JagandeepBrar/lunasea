import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LunaFirebase {
    /// Return an instance of [FirebaseApp].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseApp get app => Firebase.app();

    /// Returns an instance of [FirebaseStorage].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseStorage get storage => FirebaseStorage.instance;

    /// Initialize Firebase and configuration.
    /// 
    /// This must be called before anything accesses Firebase services, or an exception will be thrown.
    static Future<void> initialize({ String name }) async => await Firebase.initializeApp();
}

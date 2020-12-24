import 'package:firebase_storage/firebase_storage.dart';

class LunaFirebaseStorage {
    /// Returns an instance of [FirebaseStorage].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseStorage get storage => FirebaseStorage.instance;
}

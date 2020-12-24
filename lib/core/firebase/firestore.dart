import 'package:cloud_firestore/cloud_firestore.dart';

class LunaFirebaseFirestore {
    /// Returns an instance of [FirebaseFirestore].
    /// 
    /// Throws an errof if [LunaFirebase.initialize] has not been called.
    static FirebaseFirestore get instance => FirebaseFirestore.instance;
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseFirestore {
    /// Returns an instance of [FirebaseFirestore].
    /// 
    /// Throws an errof if [LunaFirebase.initialize] has not been called.
    static FirebaseFirestore get instance => FirebaseFirestore.instance;

    /// Returns a list of all backups available for this account.
    /// 
    /// If the user is not signed in, returns an empty list.
    Future<List<LunaFirebaseBackupDocument>> getBackupList() async {
        if(LunaFirebaseAuth().user == null) return [];
        QuerySnapshot snapshot = await instance.collection('users/${LunaFirebaseAuth().uid}/backups').orderBy('timestamp').get();
        return snapshot.docs.map<LunaFirebaseBackupDocument>((document) => LunaFirebaseBackupDocument.fromQueryDocumentSnapshot(document)).toList();
    }
}

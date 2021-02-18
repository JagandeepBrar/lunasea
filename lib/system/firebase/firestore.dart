import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lunasea/system/firebase.dart';
import 'package:lunasea/core/logger.dart';

class LunaFirebaseFirestore {
    /// Returns an instance of [FirebaseFirestore].
    /// 
    /// Throws an errof if [LunaFirebase.initialize] has not been called.
    static FirebaseFirestore get instance => FirebaseFirestore.instance;

    /// Add a backup entry to Firestore. Returns true if successful, and false on any error.
    /// 
    /// If the user is not signed in, returns false.
    Future<bool> addBackupEntry(String id, int timestamp, { String title = '', String description = '' }) async {
        if(!LunaFirebaseAuth().isSignedIn) return false;
        try {
            LunaFirebaseBackupDocument entry = LunaFirebaseBackupDocument(id: id, title: title, description: description, timestamp: timestamp);
            instance.doc('users/${LunaFirebaseAuth().uid}/backups/$id').set(entry.toJSON());
            return true;
        } catch (error, stack) {
            LunaLogger().error('Failed to add backup entry', error, stack);
            return false;
        }
    }

    /// Delete a backup entry from Firestore. Returns true if successful, and false on any error.
    /// 
    /// If the user is not signed in, returns false.
    Future<bool> deleteBackupEntry(String id) async {
        if(!LunaFirebaseAuth().isSignedIn) return false;
        try {
            await instance.doc('users/${LunaFirebaseAuth().uid}/backups/$id').delete();
            return true;
        } catch (error, stack) {
            LunaLogger().error('Failed to delete backup entry', error, stack);
            return false;
        }
    }

    /// Returns a list of all backups available for this account.
    /// 
    /// If the user is not signed in, returns an empty list.
    Future<List<LunaFirebaseBackupDocument>> getBackupEntries() async {
        if(LunaFirebaseAuth().user == null) return [];
        try {
            QuerySnapshot snapshot = await instance.collection('users/${LunaFirebaseAuth().uid}/backups').orderBy('timestamp', descending: true).get();
            return snapshot.docs.map<LunaFirebaseBackupDocument>((document) => LunaFirebaseBackupDocument.fromQueryDocumentSnapshot(document)).toList();
        } catch (error, stack) {
            LunaLogger().error('Failed to get backup list', error, stack);
            return [];
        }
    }

    /// Add the current device token to Firestore. Returns true if successful, and false on any error.
    Future<bool> addDeviceToken() async {
        if(!LunaFirebaseAuth().isSignedIn) return false;
        try {
            String token = await LunaFirebaseMessaging.instance.getToken();
            instance.doc('users/${LunaFirebaseAuth().uid}').set({
                'devices': FieldValue.arrayUnion([token]),
            }, SetOptions(merge: true));
            return true;
        } catch (error, stack) {
            LunaLogger().error('Failed to add device token', error, stack);
            return false;
        }
    }
}

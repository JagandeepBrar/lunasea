import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseStorage {
    static const String _BACKUP_BUCKET = 'backup.lunasea.app';

    /// Returns an instance of [FirebaseStorage] for the default bucket.
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseStorage get instanceDefault => FirebaseStorage.instance;

    /// Returns an instance of [FirebaseStorage] for the backup bucket.
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseStorage get instanceBackup => FirebaseStorage.instanceFor(bucket: _BACKUP_BUCKET);

    /// Upload a backup configuration to Firebase storage.
    /// 
    /// If the user is not signed in, returns null.
    Future<bool> uploadBackup(String data, String id) async {
        if(!LunaFirebaseAuth().isSignedIn) return false;
        try {
            await instanceBackup.ref('${LunaFirebaseAuth().uid}/$id.lunasea').putString(data);
            return true;
        } catch (error, stack) {
            LunaLogger().error('Failed to backup to Firebase', error, stack);
            return false;
        }
    }

    /// Delete a backup configuration from Firebase storage.
    /// 
    /// If the user is not signed in, returns null.
    Future<bool> deleteBackup(String id) async {
        if(!LunaFirebaseAuth().isSignedIn) return false;
        try {
            await instanceBackup.ref('${LunaFirebaseAuth().uid}/$id.lunasea').delete();
            return true;
        } catch (error, stack) {
            LunaLogger().error('Failed to delete backup from Firebase', error, stack);
            return false;
        }
    }

    /// Download a backup configuration from Firebase storage.
    /// 
    /// If the user is not signed in, returns null.
    Future<String> downloadBackup(String id) async {
        if(!LunaFirebaseAuth().isSignedIn) return null;
        try {
            Uint8List data = await instanceBackup.ref('${LunaFirebaseAuth().uid}/$id.lunasea').getData();
            return String.fromCharCodes(data);
        } catch (error, stack) {
            LunaLogger().error('Failed to download backup from Firebase', error, stack);
            return null;
        }
    }
}

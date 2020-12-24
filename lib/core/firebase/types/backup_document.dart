import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LunaFirebaseBackupDocument {
    final String documentId;
    final int timestamp;
    final String path;

    LunaFirebaseBackupDocument({
        @required this.documentId,
        @required this.timestamp,
        @required this.path,
    });

    factory LunaFirebaseBackupDocument.fromQueryDocumentSnapshot(QueryDocumentSnapshot document) => LunaFirebaseBackupDocument(
        documentId: document.id,
        timestamp: document.data()['timestamp'],
        path: document.data()['path'],
    );
}

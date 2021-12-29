import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LunaFirebaseBackupDocument {
  final String? id;
  final int? timestamp;
  final String? title;
  final String? description;

  LunaFirebaseBackupDocument({
    required this.id,
    required this.timestamp,
    required this.title,
    required this.description,
  });

  factory LunaFirebaseBackupDocument.fromQueryDocumentSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    return LunaFirebaseBackupDocument(
      id: document.data()['id'],
      timestamp: document.data()['timestamp'],
      title: document.data()['title'],
      description: document.data()['description'],
    );
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'timestamp': timestamp,
      'description': description,
    };
  }
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'indexer.g.dart';

/// Hive database object containing all information on an indexer
@HiveType(typeId: 1, adapterName: 'IndexerHiveObjectAdapter')
class IndexerHiveObject extends HiveObject {
    /// Create a new [IndexerHiveObject] object with all fields set to empty values('', false, 0, {}, etc.)
    factory IndexerHiveObject.empty() => IndexerHiveObject(
        displayName: '',
        host: '',
        apiKey: '',
        headers: {},
        icon: null,
    );

    /// Create a new [IndexerHiveObject] from another [IndexerHiveObject] (deep-copy).
    factory IndexerHiveObject.fromIndexerHiveObject(IndexerHiveObject indexer) => IndexerHiveObject(
        displayName: indexer.displayName,
        host: indexer.host,
        apiKey: indexer.apiKey,
        headers: indexer.headers,
        icon: indexer.icon,
    );

    /// Create a new [IndexerHiveObject] from a map where the keys map 1-to-1 except for "key", which was the old key for apiKey.
    /// 
    /// - Does _not_ do type checking, and will throw an error if the type is invalid.
    /// - If the key is null, sets to the "empty" value
    factory IndexerHiveObject.fromMap(Map indexer) => IndexerHiveObject(
        displayName: indexer['displayName'] ?? '',
        host: indexer['host'] ?? '',
        apiKey: indexer['key'] ?? '',
        headers: indexer['headers'] ?? {},
        icon: LunaIndexerIcon.GENERIC.fromKey(indexer['icon'] ?? ''),
    );

    IndexerHiveObject({
        @required this.displayName,
        @required this.host,
        @required this.apiKey,
        @required this.headers,
        @required this.icon,
    });

    @override
    String toString() => toMap().toString();

    Map<String, dynamic> toMap() => {
        "displayName": displayName ?? '',
        "host": host ?? '',
        "key": apiKey ?? '',
        "headers": headers ?? {},
        "icon": icon?.key ?? '',
    };

    @HiveField(0)
    String displayName;
    @HiveField(1)
    String host;
    @HiveField(2)
    String apiKey;
    @HiveField(3)
    Map headers;
    @HiveField(4)
    LunaIndexerIcon icon;
}

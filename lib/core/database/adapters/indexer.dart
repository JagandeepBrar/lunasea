import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'indexer.g.dart';

@HiveType(typeId: 1, adapterName: 'IndexerHiveObjectAdapter')
class IndexerHiveObject extends HiveObject {
    factory IndexerHiveObject.empty() {
        return IndexerHiveObject(
            displayName: '',
            host: '',
            key: '',
            headers: {},
        );
    }

    factory IndexerHiveObject.from(IndexerHiveObject obj) {
        return IndexerHiveObject(
            displayName: obj.displayName,
            host: obj.host,
            key: obj.key,
            headers: obj.headers,
        );
    }

    IndexerHiveObject({
        @required this.displayName,
        @required this.host,
        @required this.key,
        @required this.headers,
    });

    @override
    String toString() {
        return toMap().toString();
    }

    Map<String, dynamic> toMap() {
        return {
            "displayName": displayName ?? '',
            "host": host ?? '',
            "key": key ?? '',
            "headers": headers ?? {},
        };
    }

    @HiveField(0)
    String displayName;
    @HiveField(1)
    String host;
    @HiveField(2)
    String key;
    @HiveField(3)
    Map headers;
}

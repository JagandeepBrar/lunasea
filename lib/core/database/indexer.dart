import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'indexer.g.dart';

@HiveType(typeId: 1, adapterName: 'IndexerHiveObjectAdapter')
class IndexerHiveObject extends HiveObject {
    factory IndexerHiveObject.empty(String displayName) {
        return IndexerHiveObject(
            displayName: displayName,
        );
    }

    IndexerHiveObject({
        @required this.displayName,
    });

    @override
    String toString() {
        return {
            "displayName": displayName,
        }.toString();
    }

    @HiveField(0)
    String displayName;
}

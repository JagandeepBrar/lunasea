import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lunasea/system/database/objects.dart';

class Database { 
    Database._();

    static Future<void> initialize() async {
        await Hive.initFlutter();
        await openBoxes();
    }

    void registerAdapters() {
        Hive.registerAdapter(IndexerAdapter());
        Hive.registerAdapter(ProfileAdapter());
    }

    static Future<void> openBoxes() async {
        await Hive.openBox('lunasea');
        await Hive.openBox<Indexer>('indexers');
        await Hive.openBox<Profile>('profiles');
    }
}
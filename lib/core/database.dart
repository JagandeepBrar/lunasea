// Imports
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './database/objects.dart';
// Exports
export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';
export './database/objects.dart';

class Database { 
    Database._();

    static Future<void> initialize() async {
        await Hive.initFlutter('database');
        registerAdapters();
        await openBoxes();
        setDefaults();
    }

    static void registerAdapters() {
        Hive.registerAdapter(IndexerHiveObjectAdapter());
        Hive.registerAdapter(ProfileHiveObjectAdapter());
    }

    static Future<void> openBoxes() async {
        await Hive.openBox('lunasea');
        await Hive.openBox<IndexerHiveObject>('indexers');
        await Hive.openBox<ProfileHiveObject>('profiles');
    }

    static void setDefaults() {
        if(!getProfilesBox().keys.contains('default'))
            getProfilesBox().put('default', ProfileHiveObject.empty());
        if(!getLunaSeaBox().keys.contains('profile'))
            getLunaSeaBox().put('profile', 'default');
    }

    //Get boxes
    static Box getLunaSeaBox() => Hive.box('lunasea');
    static Box getProfilesBox() => Hive.box<ProfileHiveObject>('profiles');
    static Box getIndexersBox() => Hive.box<IndexerHiveObject>('indexers');

    //Clear boxes
    static void clearLunaSeaBox() => getLunaSeaBox().deleteAll(getLunaSeaBox().keys);
    static void clearProfilesBox() => getProfilesBox().deleteAll(getProfilesBox().keys);
    static void clearIndexersBox() => getIndexersBox().deleteAll(getIndexersBox().keys);

    //Profile values
    static String get currentProfile => getLunaSeaBox().get('profile');
    static ProfileHiveObject get currentProfileObject => getProfilesBox().get(currentProfile);
}

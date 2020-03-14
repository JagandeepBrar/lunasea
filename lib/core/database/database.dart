// Imports
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './adapters.dart';
// Exports
export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';

class Database { 
    Database._();

    static Future<void> initialize() async {
        await Hive.initFlutter('database');
        _registerAdapters();
        await _openBoxes();
        _setDefaults();
    }

    static void _registerAdapters() {
        Hive.registerAdapter(IndexerHiveObjectAdapter());
        Hive.registerAdapter(ProfileHiveObjectAdapter());
    }

    static Future<void> _openBoxes() async {
        await Hive.openBox('lunasea');
        await Hive.openBox<IndexerHiveObject>('indexers');
        await Hive.openBox<ProfileHiveObject>('profiles');
    }

    static void _setDefaults() {
        if(!profilesBox.keys.contains('default'))
            profilesBox.put('default', ProfileHiveObject.empty());
        if(!lunaSeaBox.keys.contains('profile'))
            lunaSeaBox.put('profile', 'default');
    }

    //Get boxes
    static Box get lunaSeaBox => Hive.box('lunasea');
    static Box get profilesBox => Hive.box<ProfileHiveObject>('profiles');
    static Box get indexersBox => Hive.box<IndexerHiveObject>('indexers');

    //Clear boxes
    static void clearLunaSeaBox() => lunaSeaBox.deleteAll(lunaSeaBox.keys);
    static void clearProfilesBox() => profilesBox.deleteAll(profilesBox.keys);
    static void clearIndexersBox() => indexersBox.deleteAll(indexersBox.keys);

    //Profile values
    static String get currentProfile => lunaSeaBox.get('profile');
    static ProfileHiveObject get currentProfileObject => profilesBox.get(currentProfile);
}

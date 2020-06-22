// Imports
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lunasea/modules.dart';
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
        if(profilesBox.keys.length == 0) setDefaults();
    }

    static Future<void> deinitialize() async => await Hive.close();

    static void _registerAdapters() {
        //Core
        Hive.registerAdapter(IndexerHiveObjectAdapter());
        Hive.registerAdapter(ProfileHiveObjectAdapter());
        //General
        LunaSeaDatabase.registerAdapters();
        HomeDatabase.registerAdapters();
        SearchDatabase.registerAdapters();
        SettingsDatabase.registerAdapters();
        //Automation
        LidarrDatabase.registerAdapters();
        RadarrDatabase.registerAdapters();
        SonarrDatabase.registerAdapters();
        //Clients
        NZBGetDatabase.registerAdapters();
        SABnzbdDatabase.registerAdapters();
    }

    static Future<void> _openBoxes() async {
        await Hive.openBox('lunasea');
        await Hive.openBox<IndexerHiveObject>('indexers');
        await Hive.openBox<ProfileHiveObject>('profiles');
    }

    static void setDefaults() {
        //Clear all the boxes
        clearLunaSeaBox();
        clearProfilesBox();
        clearIndexersBox();
        //Set default profile & enabled profile
        profilesBox.put('default', ProfileHiveObject.empty());
        lunaSeaBox.put(LunaSeaDatabaseValue.ENABLED_PROFILE.key, 'default');
        
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

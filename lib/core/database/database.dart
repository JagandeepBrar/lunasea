// Imports
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home/core.dart' show HomeDatabase;
import 'package:lunasea/modules/search/core.dart' show SearchDatabase;
import 'package:lunasea/modules/settings/core.dart' show SettingsDatabase;
import 'package:lunasea/modules/lidarr/core.dart' show LidarrDatabase;
import 'package:lunasea/modules/radarr/core.dart' show RadarrDatabase;
import 'package:lunasea/modules/sonarr/core.dart' show SonarrDatabase;
import 'package:lunasea/modules/nzbget/core.dart' show NZBGetDatabase;
import 'package:lunasea/modules/sabnzbd/core.dart' show SABnzbdDatabase;
import 'package:lunasea/modules/tautulli/core.dart' show TautulliDatabase;
// Exports
export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';

class Database {
    static const String _DATABASE_PATH = 'database';

    /// Initialize the database.
    /// 
    /// - Initializes Hive database path
    /// - Register all adapters
    /// - Open all boxes
    /// - Set default database state of necessary
    static Future<void> initialize() async {
        await Hive.initFlutter(_DATABASE_PATH);
        _registerAdapters();
        await _openBoxes();
        if(profilesBox.keys.length == 0) setDefaults(clearAlerts: true);
    }

    /// Deinitialize the database by closing all open hive boxes.
    static Future<void> deinitialize() async => await Hive.close();

    /// Registers all necessary object adapters for Hive.
    static void _registerAdapters() {
        //Core
        Hive.registerAdapter(IndexerHiveObjectAdapter());
        Hive.registerAdapter(ProfileHiveObjectAdapter());
        //General
        LunaDatabase().registerAdapters();
        HomeDatabase().registerAdapters();
        SearchDatabase().registerAdapters();
        SettingsDatabase().registerAdapters();
        //Automation
        LidarrDatabase().registerAdapters();
        RadarrDatabase().registerAdapters();
        SonarrDatabase().registerAdapters();
        //Clients
        NZBGetDatabase().registerAdapters();
        SABnzbdDatabase().registerAdapters();
        //Monitoring
        TautulliDatabase().registerAdapters();
    }

    /// Open all Hive boxes for reading.
    static Future<void> _openBoxes() async {
        await Hive.openBox('lunasea');
        await Hive.openBox('alerts');
        await Hive.openBox<IndexerHiveObject>('indexers');
        await Hive.openBox<ProfileHiveObject>('profiles');
    }

    /// Set the default state for all hive boxes.
    static void setDefaults({ bool clearAlerts = false }) {
        //Clear all the boxes
        clearAllBoxes(clearAlerts: clearAlerts);
        //Set default profile & enabled profile
        profilesBox.put('default', ProfileHiveObject.empty());
        lunaSeaBox.put(LunaDatabaseValue.ENABLED_PROFILE.key, 'default');
    }

    //Get boxes
    static Box get lunaSeaBox => Hive.box('lunasea');
    static Box get alertsBox => Hive.box('alerts');
    static Box get profilesBox => Hive.box<ProfileHiveObject>('profiles');
    static Box get indexersBox => Hive.box<IndexerHiveObject>('indexers');

    //Clear boxes
    static void clearLunaSeaBox() => lunaSeaBox.deleteAll(lunaSeaBox.keys);
    static void clearProfilesBox() => profilesBox.deleteAll(profilesBox.keys);
    static void clearIndexersBox() => indexersBox.deleteAll(indexersBox.keys);
    static void clearAlertsBox() => alertsBox.deleteAll(alertsBox.keys);
    static void clearAllBoxes({ bool clearAlerts = false }) {
        clearLunaSeaBox();
        clearProfilesBox();
        clearIndexersBox();
        if(clearAlerts) clearAlertsBox();
    }

    //Profile values
    static String get currentProfile => lunaSeaBox.get('profile');
    static ProfileHiveObject get currentProfileObject => profilesBox.get(currentProfile);
}

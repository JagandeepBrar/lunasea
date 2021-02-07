import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings/core.dart' show SettingsDatabase, SettingsConstants;
import 'package:lunasea/modules/home/core.dart' show HomeDatabase, HomeConstants;
import 'package:lunasea/modules/search/core.dart' show SearchDatabase, SearchConstants;
import 'package:lunasea/modules/lidarr/core.dart' show LidarrDatabase, LidarrConstants;
import 'package:lunasea/modules/radarr/core.dart' show RadarrDatabase, RadarrConstants;
import 'package:lunasea/modules/sonarr/core.dart' show SonarrDatabase, SonarrConstants;
import 'package:lunasea/modules/nzbget/core.dart' show NZBGetDatabase, NZBGetConstants;
import 'package:lunasea/modules/sabnzbd/core.dart' show SABnzbdDatabase, SABnzbdConstants;
import 'package:lunasea/modules/tautulli/core.dart' show TautulliDatabase, TautulliConstants;

class LunaConfiguration {
    /// Returns a list of all profiles converted to a map. 
    List<Map<String, dynamic>> _getProfiles() {
        List<Map<String, dynamic>> _data = [];
        for(var key in Database.profilesBox.keys) _data.add(Database.profilesBox.get(key).toMap());
        return _data;
    }

    /// Given a list of map objects, creates or updates profiles for each object.
    void _setProfiles(List data) {
        Box<dynamic> box = Database.profilesBox;
        for(Map profile in data) box.put(profile['key'], ProfileHiveObject.fromMap(profile));
    }

    /// Returns a list of all indexers converted to a map. 
    List<Map<String, dynamic>> _getIndexers() {
        List<Map<String, dynamic>> _data = [];
        for(var key in Database.indexersBox.keys) _data.add(Database.indexersBox.get(key).toMap());
        return _data;
    }
    
    /// Given a list of map objects, creates or updates indexers for each object.
    void _setIndexers(List data) {
        Box<dynamic> box = Database.indexersBox;
        for(Map indexer in data) box.add(IndexerHiveObject.fromMap(indexer));
    }

    /// Import the entire configuration from a JSON-encoded string (typically read through a `.lunasea` backup file).
    /// 
    /// - Clears all boxes
    /// - Calls `_setProfiles()` and `_setIndexers()`
    /// - Calls `import()` on all module databases, which implement [LunaDatabase].
    /// - Resets the application state
    /// 
    /// On a failed import, resets LunaSea back to the default/base state
    Future<void> import(BuildContext context, String data) async {
        Map config = json.decode(data);
        Database.clearAllBoxes();
        try {
            // Set the profilers, indexer, and global LunaSea boxes
            if(config['profiles'] != null) _setProfiles(config['profiles']);
            if(config['indexers'] != null) _setIndexers(config['indexers']);
            if(config['lunasea'] != null) LunaDatabase().import(config['lunasea']);
            // General
            if(config[SettingsConstants.MODULE_KEY] != null) SettingsDatabase().import(config[SettingsConstants.MODULE_KEY]);
            if(config[HomeConstants.MODULE_KEY] != null) HomeDatabase().import(config[HomeConstants.MODULE_KEY]);
            if(config[SearchConstants.MODULE_KEY] != null) SearchDatabase().import(config[SearchConstants.MODULE_KEY]);
            // Automation
            if(config[LidarrConstants.MODULE_KEY] != null) LidarrDatabase().import(config[LidarrConstants.MODULE_KEY]);
            if(config[RadarrConstants.MODULE_KEY] != null) RadarrDatabase().import(config[RadarrConstants.MODULE_KEY]);
            if(config[SonarrConstants.MODULE_KEY] != null) SonarrDatabase().import(config[SonarrConstants.MODULE_KEY]);
            // Clients
            if(config[NZBGetConstants.MODULE_KEY] != null) NZBGetDatabase().import(config[NZBGetConstants.MODULE_KEY]);
            if(config[SABnzbdConstants.MODULE_KEY] != null) SABnzbdDatabase().import(config[SABnzbdConstants.MODULE_KEY]);
            //Monitoring
            if(config[TautulliConstants.MODULE_KEY] != null) TautulliDatabase().import(config[TautulliConstants.MODULE_KEY]);
        } catch (error, stack) {
            LunaLogger().error('Failed to import configuration, resetting to default', error, stack);
            Database.setDefaults();
        }
        // Reset the entire app's state
        LunaState.reset(context);
    }

    /// Converts the entire application configuration/database into a JSON string.
    /// 
    /// - Calls `_getProfiles()` and `_getIndexers()`
    /// - Calls `export()` on all module databases, which implement [LunaModuleDatabase].
    String export() => json.encode({
        "profiles": _getProfiles(),
        "indexers": _getIndexers(),
        "lunasea": LunaDatabase().export(),
        // General
        SettingsConstants.MODULE_KEY: SettingsDatabase().export(),
        HomeConstants.MODULE_KEY: HomeDatabase().export(),
        SearchConstants.MODULE_KEY: SearchDatabase().export(),
        // Automation
        LidarrConstants.MODULE_KEY: LidarrDatabase().export(),
        RadarrConstants.MODULE_KEY: RadarrDatabase().export(),
        SonarrConstants.MODULE_KEY: SonarrDatabase().export(),
        // Clients
        NZBGetConstants.MODULE_KEY: NZBGetDatabase().export(),
        SABnzbdConstants.MODULE_KEY: SABnzbdDatabase().export(),
        // Monitoring
        TautulliConstants.MODULE_KEY: TautulliDatabase().export(),
    });
}

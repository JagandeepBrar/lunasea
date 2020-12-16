import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart' show
    SettingsDatabase, SettingsConstants,
    HomeDatabase, HomeConstants,
    SearchDatabase, SearchConstants,
    LidarrDatabase, LidarrConstants,
    RadarrDatabase, RadarrConstants,
    SonarrDatabase, SonarrConstants,
    NZBGetDatabase, NZBGetConstants,
    SABnzbdDatabase, SABnzbdConstants,
    OmbiDatabase, OmbiConstants,
    TautulliDatabase, TautulliConstants;

class ImportConfiguration {
    void _setProfiles(List data) {
        Box<dynamic> box = Database.profilesBox;
        for(Map profile in data) {
            box.put(profile['key'], ProfileHiveObject(
                //Sonarr
                sonarrEnabled: profile['sonarrEnabled'] ?? false,
                sonarrHost: profile['sonarrHost'] ?? '',
                sonarrKey: profile['sonarrKey'] ?? '',
                sonarrVersion3: profile['sonarrVersion3'] ?? false,
                sonarrHeaders: profile['sonarrHeaders'] ?? {},
                //Radarr
                radarrEnabled: profile['radarrEnabled'] ?? false,
                radarrHost: profile['radarrHost'] ?? '',
                radarrKey: profile['radarrKey'] ?? '',
                radarrHeaders: profile['radarrHeaders'] ?? {},
                //Lidarr
                lidarrEnabled: profile['lidarrEnabled'] ?? false,
                lidarrHost: profile['lidarrHost'] ?? '',
                lidarrKey: profile['lidarrKey'] ?? '',
                lidarrHeaders: profile['lidarrHeaders'] ?? {},
                //SABnzbd
                sabnzbdEnabled: profile['sabnzbdEnabled'] ?? false,
                sabnzbdHost: profile['sabnzbdHost'] ?? '',
                sabnzbdKey: profile['sabnzbdKey'] ?? '',
                sabnzbdHeaders: profile['sabnzbdHeaders'] ?? {},
                //NZBGet
                nzbgetEnabled: profile['nzbgetEnabled'] ?? false,
                nzbgetHost: profile['nzbgetHost'] ?? '',
                nzbgetUser: profile['nzbgetUser'] ?? '',
                nzbgetPass: profile['nzbgetPass'] ?? '',
                nzbgetBasicAuth: profile['nzbgetBasicAuth'] ?? false,
                nzbgetHeaders: profile['nzbgetHeaders'] ?? {},
                //Wake on LAN
                wakeOnLANEnabled: profile['wakeOnLANEnabled'] ?? false,
                wakeOnLANBroadcastAddress: profile['wakeOnLANBroadcastAddress'] ?? '',
                wakeOnLANMACAddress: profile['wakeOnLANMACAddress'] ?? '',
                //Tautulli
                tautulliEnabled: profile['tautulliEnabled'] ?? false,
                tautulliHost: profile['tautulliHost'] ?? '',
                tautulliKey: profile['tautulliKey'] ?? '',
                tautulliHeaders: profile['tautulliHeaders'] ?? {},
                //Ombi
                ombiEnabled: profile['ombiEnabled'] ?? false,
                ombiHost: profile['ombiHost'] ?? '',
                ombiKey: profile['ombiKey'] ?? '',
                ombiHeaders: profile['ombiHeaders'] ?? {},
            ));
        }
    }
    
    void _setIndexers(List data) {
        Box<dynamic> box = Database.indexersBox;
        for(Map indexer in data) {
            box.add(IndexerHiveObject(
                displayName: indexer['displayName'] ?? '',
                host: indexer['host'] ?? '',
                key: indexer['key'] ?? '',
                headers: indexer['headers'] ?? {},
            ));
        }
    }

    Future<void> import(BuildContext context, String data) async {
        Map config = json.decode(data);
        // Clear boxes
        Database.clearIndexersBox();
        Database.clearLunaSeaBox();
        Database.clearProfilesBox();
        // Set the profilers, indexer, and global LunaSea boxes
        if(config['profiles'] != null) _setProfiles(config['profiles']);
        if(config['indexers'] != null) _setIndexers(config['indexers']);
        if(config['lunasea'] != null) LunaSeaDatabase().import(config['lunasea']);
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
        if(config[OmbiConstants.MODULE_KEY] != null) OmbiDatabase().import(config[OmbiConstants.MODULE_KEY]);
        if(config[TautulliConstants.MODULE_KEY] != null) TautulliDatabase().import(config[TautulliConstants.MODULE_KEY]);
        // Reset the entire app's state
        LunaProvider.reset(context);
    }
}

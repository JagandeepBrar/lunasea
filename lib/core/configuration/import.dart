import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/modules.dart' show HomeDatabase, HomeConstants;

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
        // Assign the profilers and indexer boxes
        if(config['profiles'] != null) _setProfiles(config['profiles']);
        if(config['indexers'] != null) _setIndexers(config['indexers']);
        // Assign everything contained within the LunaSea box
        if(config['lunasea'] != null) LunaSeaDatabase().import(config['lunasea']);
        if(config[HomeConstants.MODULE_KEY] != null) HomeDatabase().import(config[HomeConstants.MODULE_KEY]);
        LunaProvider.reset(context);
    }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/core/database.dart';

class Import {
    Import._();

    static void _setLunaSea(BuildContext context, Map data) {
        LunaProfile.changeProfile(context, data['profile']);
    }

    static void _setProfiles(List data) {
        Box<dynamic> _box = Database.profilesBox;
        for(Map profile in data) {
            _box.put(profile['key'], ProfileHiveObject(
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
    
    static void _setIndexers(List data) {
        Box<dynamic> _box = Database.indexersBox;
        for(Map indexer in data) {
            _box.add(IndexerHiveObject(
                displayName: indexer['displayName'] ?? '',
                host: indexer['host'] ?? '',
                key: indexer['key'] ?? '',
                headers: indexer['headers'] ?? {},
            ));
        }
    }

    static bool _validate(Map config) {
        if(
            config['profiles'] != null &&
            config['indexers'] != null &&
            config['lunasea'] != null
        ) return true;
        return false;
    }

    static void _clearBoxes() {
        Database.clearIndexersBox();
        Database.clearLunaSeaBox();
        Database.clearProfilesBox();
    }

    static Future<bool> import(BuildContext context, String data) async {
        Map _config = json.decode(data);
        if(_validate(_config)) {
            _clearBoxes();
            _setProfiles(_config['profiles']);
            _setIndexers(_config['indexers']);
            _setLunaSea(context, _config['lunasea']);
            return true;
        }
        return false;
    }
}

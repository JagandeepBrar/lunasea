import 'dart:convert';
import 'package:lunasea/core/database.dart';

class Import {
    Import._();

    static void _setLunaSea(Map data) {
        LunaSeaDatabaseValue.ENABLED_PROFILE.put(data['profile']);
    }

    static void _setProfiles(List data) {
        Box<dynamic> _box = Database.profilesBox;
        for(Map profile in data) {
            _box.put(profile['key'], ProfileHiveObject(
                //Sonarr
                sonarrEnabled: profile['sonarrEnabled'] ?? false,
                sonarrHost: profile['sonarrHost'] ?? '',
                sonarrKey: profile['sonarrKey'] ?? '',
                sonarrStrictTLS: profile['sonarrStrictTLS'] ?? true,
                sonarrVersion3: profile['sonarrVersion3'] ?? false,
                sonarrHeaders: profile['sonarrHeaders'] ?? {},
                //Radarr
                radarrEnabled: profile['radarrEnabled'] ?? false,
                radarrHost: profile['radarrHost'] ?? '',
                radarrKey: profile['radarrKey'] ?? '',
                radarrStrictTLS: profile['radarrStrictTLS'] ?? true,
                radarrHeaders: profile['radarrHeaders'] ?? {},
                //Lidarr
                lidarrEnabled: profile['lidarrEnabled'] ?? false,
                lidarrHost: profile['lidarrHost'] ?? '',
                lidarrKey: profile['lidarrKey'] ?? '',
                lidarrStrictTLS: profile['lidarrStrictTLS'] ?? true,
                lidarrHeaders: profile['lidarrHeaders'] ?? {},
                //SABnzbd
                sabnzbdEnabled: profile['sabnzbdEnabled'] ?? false,
                sabnzbdHost: profile['sabnzbdHost'] ?? '',
                sabnzbdKey: profile['sabnzbdKey'] ?? '',
                sabnzbdStrictTLS: profile['sabnzbdStrictTLS'] ?? true,
                sabnzbdHeaders: profile['sabnzbdHeaders'] ?? {},
                //NZBGet
                nzbgetEnabled: profile['nzbgetEnabled'] ?? false,
                nzbgetHost: profile['nzbgetHost'] ?? '',
                nzbgetUser: profile['nzbgetUser'] ?? '',
                nzbgetPass: profile['nzbgetPass'] ?? '',
                nzbgetStrictTLS: profile['nzbgetStrictTLS'] ?? true,
                nzbgetBasicAuth: profile['nzbgetBasicAuth'] ?? false,
                nzbgetHeaders: profile['nzbgetHeaders'] ?? {},
                //Wake on LAN
                wakeOnLANEnabled: profile['wakeOnLANEnabled'] ?? false,
                wakeOnLANBroadcastAddress: profile['wakeOnLANBroadcastAddress'] ?? '',
                wakeOnLANMACAddress: profile['wakeOnLANMACAddress'] ?? '',
            ));
        }
    }
    
    static void _setIndexers(List data) {
        Box<dynamic> _box = Database.indexersBox;
        for(Map indexer in data) {
            _box.add(IndexerHiveObject(
                displayName: indexer['displayName'],
                host: indexer['host'],
                key: indexer['key'],
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

    static Future<bool> import(String data) async {
        Map _config = json.decode(data);
        if(_validate(_config)) {
            _clearBoxes();
            _setProfiles(_config['profiles']);
            _setIndexers(_config['indexers']);
            _setLunaSea(_config['lunasea']);
            return true;
        }
        return false;
    }
}

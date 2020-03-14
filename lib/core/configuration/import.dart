import 'dart:convert';
import 'package:lunasea/core/database.dart';

class Import {
    Import._();

    static void _setLunaSea(Map data) {
        Box<dynamic> _box = Database.lunaSeaBox;
        _box.put('profile', data['profile']);
    }

    static void _setProfiles(List data) {
        Box<dynamic> _box = Database.profilesBox;
        for(Map profile in data) {
            _box.put(profile['key'], ProfileHiveObject(
                //Sonarr
                sonarrEnabled: profile['sonarrEnabled'] ?? false,
                sonarrHost: profile['sonarrHost'] ?? '',
                sonarrKey: profile['sonarrKey'] ?? '',
                //Radarr
                radarrEnabled: profile['radarrEnabled'] ?? false,
                radarrHost: profile['radarrHost'] ?? '',
                radarrKey: profile['radarrKey'] ?? '',
                //Lidarr
                lidarrEnabled: profile['lidarrEnabled'] ?? false,
                lidarrHost: profile['lidarrHost'] ?? '',
                lidarrKey: profile['lidarrKey'] ?? '',
                //SABnzbd
                sabnzbdEnabled: profile['sabnzbdEnabled'] ?? false,
                sabnzbdHost: profile['sabnzbdHost'] ?? '',
                sabnzbdKey: profile['sabnzbdKey'] ?? '',
                //NZBGet
                nzbgetEnabled: profile['nzbgetEnabled'] ?? false,
                nzbgetHost: profile['nzbgetHost'] ?? '',
                nzbgetUser: profile['nzbgetUser'] ?? '',
                nzbgetPass: profile['nzbgetPass'] ?? '',
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

    static void _clearBoxes() {
        Database.clearIndexersBox();
        Database.clearLunaSeaBox();
        Database.clearProfilesBox();
    }

    static Future<void> import(String data) async {
        _clearBoxes();
        Map _config = json.decode(data);
        _setProfiles(_config['profiles']);
        _setIndexers(_config['indexers']);
        _setLunaSea(_config['lunasea']);
    }
}

// Imports
import 'package:hive/hive.dart';
// Exports
export 'package:hive/hive.dart';

class AppState {
    AppState._();

    static Future<void> initialize() async {
        await _openBoxes();
        _cleanSlate();
    }

    static Future<void> _openBoxes() async {
        await Hive.openBox('state_lidarr');
        await Hive.openBox('state_radarr');
        await Hive.openBox('state_sonarr');
        await Hive.openBox('state_sabnzbd');
        await Hive.openBox('state_nzbget');
        await Hive.openBox('state_home');
    }

    static void _cleanSlate() async {
        lidarrState.clear();
        radarrState.clear();
        sonarrState.clear();
        sabnzbdState.clear();
        nzbgetState.clear();
        homeState.clear();
    }

    static Box get lidarrState => Hive.box('state_lidarr');
    static Box get radarrState => Hive.box('state_radarr');
    static Box get sonarrState => Hive.box('state_sonarr');
    static Box get sabnzbdState => Hive.box('state_sabnzbd');
    static Box get nzbgetState => Hive.box('state_nzbget');
    static Box get homeState => Hive.box('state_home');
}
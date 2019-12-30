import 'package:validators/sanitizers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Values {
    Values._();
    
    static List<dynamic> lidarrValues = [false, '', ''];
    static List<dynamic> radarrValues = [false, '', ''];
    static List<dynamic> sonarrValues = [false, '', ''];
    static List<dynamic> sabnzbdValues = [false, '', ''];

    static List<String> getEnabledServices() {
        List<String> services = [];
        if(lidarrValues[0]) {
            services.add('lidarr');
        }
        if(radarrValues[0]) {
            services.add('radarr');
        }
        if(sonarrValues[0]) {
            services.add('sonarr');
        }
        if(sabnzbdValues[0]) {
            services.add('sabnzbd');
        }
        return services;
    }

    static bool anyAutomationEnabled() {
        return lidarrValues[0] || radarrValues[0] || sonarrValues[0];
    }

    static bool anyClientsEnabled() {
        return sabnzbdValues[0];
    }

    static void pullSabnzbd(List<dynamic> values) {
        values[0] is bool ?
            sabnzbdValues = [values[0], values[1], values[2]] :
            sabnzbdValues = [toBoolean(values[0]), values[1], values[2]];
    }

    static Future<void> setSabnzbd(List<dynamic> values) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList('${prefs.getString('enabled_profile')}_sabnzbd', [values[0].toString(), values[1], values[2]]);
        pullSabnzbd(values);
    }

    static void pullLidarr(List<dynamic> values) {
        values[0] is bool ?
            lidarrValues = [values[0], values[1], values[2]] :
            lidarrValues = [toBoolean(values[0]), values[1], values[2]];
    }

    static Future<void> setLidarr(List<dynamic> values) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList('${prefs.getString('enabled_profile')}_lidarr', [values[0].toString(), values[1], values[2]]);
        pullLidarr(values);
    }

    static void pullRadarr(List<dynamic> values) {
        values[0] is bool ?
            radarrValues = [values[0], values[1], values[2]] :
            radarrValues = [toBoolean(values[0]), values[1], values[2]];
    }

    static Future<void> setRadarr(List<dynamic> values) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList('${prefs.getString('enabled_profile')}_radarr', [values[0].toString(), values[1], values[2]]);
        pullRadarr(values);
    }

    static void pullSonarr(List<dynamic> values) {
        values[0] is bool ?
            sonarrValues = [values[0], values[1], values[2]] :
            sonarrValues = [toBoolean(values[0]), values[1], values[2]];
    }

    static Future<void> setSonarr(List<dynamic> values) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList('${prefs.getString('enabled_profile')}_sonarr', [values[0].toString(), values[1], values[2]]);
        pullSonarr(values);
    }
}
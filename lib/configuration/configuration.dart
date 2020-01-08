import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/configuration/profiles.dart';

class Configuration {
    Configuration._();
    
    static Future<void> pullAndSanitizeValues() async {
        await sanitizeValues();
        await pullValues();
    }

    static Future<void> sanitizeValues() async {
        final prefs = await SharedPreferences.getInstance();
        List<String> profiles = prefs.getStringList('profiles');
        //Check profiles
        if(profiles == null || profiles.length == 0) {
            prefs.setStringList('profiles', ['Default']);
            profiles = prefs.getStringList('profiles');
        }
        //Check enabled profile
        if(prefs.getString('enabled_profile') == null) {
            prefs.setString('enabled_profile', 'Default');
        }
        //Check individual profiles to ensure validity
        for(String profile in profiles) {
            //Automation
            if(prefs.getStringList('${profile}_lidarr') == null) {
                prefs.setStringList('${profile}_lidarr', ['false', '', '']);
            }
            if(prefs.getStringList('${profile}_radarr') == null) {
                prefs.setStringList('${profile}_radarr', ['false', '', '']);
            }
            if(prefs.getStringList('${profile}_sonarr') == null) {
                prefs.setStringList('${profile}_sonarr', ['false', '', '']);
            }
            //Clients
            if(prefs.getStringList('${profile}_sabnzbd') == null) {
                prefs.setStringList('${profile}_sabnzbd', ['false', '', '']);
            }
            if(prefs.getStringList('${profile}_nzbget') == null) {
                prefs.setStringList('${profile}_nzbget', ['false', '', '', '']);
            }
        }
    }

    static Future<void> pullValues() async {
        final prefs = await SharedPreferences.getInstance();
        //Pull profiles
        Profiles.pullEnabledProfile(prefs.getString('enabled_profile'));
        Profiles.pullProfiles(prefs.getStringList('profiles'));
        //Pull automation values
        Values.pullLidarr(prefs.getStringList('${prefs.getString('enabled_profile')}_lidarr'));
        Values.pullRadarr(prefs.getStringList('${prefs.getString('enabled_profile')}_radarr'));
        Values.pullSonarr(prefs.getStringList('${prefs.getString('enabled_profile')}_sonarr'));
        //Pull client values
        Values.pullSabnzbd(prefs.getStringList('${prefs.getString('enabled_profile')}_sabnzbd'));
        Values.pullNZBGet(prefs.getStringList('${prefs.getString('enabled_profile')}_nzbget'));
    }

    static Future<void> clearValues() async {
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
    }

    static Future<String> exportConfig() async {
        final prefs = await SharedPreferences.getInstance();
        Map config = {};
        config['enabled_profile'] = Profiles.enabledProfile;
        config['profiles'] = Profiles.profileList;
        for(var profile in Profiles.profileList) {
            config['$profile'] = {};
            //Automation
            config['$profile']['${profile}_lidarr'] = prefs.getStringList('${profile}_lidarr');
            config['$profile']['${profile}_radarr'] = prefs.getStringList('${profile}_radarr');
            config['$profile']['${profile}_sonarr'] = prefs.getStringList('${profile}_sonarr');
            //Clients
            config['$profile']['${profile}_sabnzbd'] = prefs.getStringList('${profile}_sabnzbd');
            config['$profile']['${profile}_nzbget'] = prefs.getStringList('${profile}_nzbget');
        }
        return json.encode(config);
    }

    static Future<bool> importConfig(String json) async {
        if(json != null) {
            try {
                Map config = jsonDecode(json);
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                //Profiles
                prefs.setString('enabled_profile', config['enabled_profile']);
                prefs.setStringList('profiles', List<String>.from(config['profiles']));
                //Services
                for(var profile in config['profiles']) {
                    //Automation
                    if(config['$profile']['${profile}_lidarr'] != null) {
                        prefs.setStringList('${profile}_lidarr', List<String>.from(config['$profile']['${profile}_lidarr']));
                    }
                    if(config['$profile']['${profile}_radarr'] != null) {
                        prefs.setStringList('${profile}_radarr', List<String>.from(config['$profile']['${profile}_radarr']));
                    }
                    if(config['$profile']['${profile}_sonarr'] != null) {
                        prefs.setStringList('${profile}_sonarr', List<String>.from(config['$profile']['${profile}_sonarr']));
                    }
                    //Clients
                    if(config['$profile']['${profile}_sabnzbd'] != null) {
                        prefs.setStringList('${profile}_sabnzbd', List<String>.from(config['$profile']['${profile}_sabnzbd']));
                    }
                    if(config['$profile']['${profile}_nzbget'] != null) {
                        prefs.setStringList('${profile}_nzbget', List<String>.from(config['$profile']['${profile}_nzbget']));
                    }
                }
                return true;
            } catch (e) {
                return false;
            }
        }
        return false;
    }
}
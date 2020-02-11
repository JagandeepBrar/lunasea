import 'package:shared_preferences/shared_preferences.dart';
import 'package:lunasea/system.dart';

class Profiles {
    Profiles._();
    
    static String enabledProfile = '';
    static List<String> profileList = [];

    static void pullEnabledProfile(String name) {
        enabledProfile = name;
    }

    static void pullProfiles(List<String> profiles) {
        profileList = profiles;
    }

    static Future<bool> profileExists(String name) async {
        final prefs = await SharedPreferences.getInstance();
        profileList = prefs.getStringList('profiles');
        if(profileList.contains(name)) return true;
        return false;
    }

    static Future<void> createProfile(String name) async {
        final prefs = await SharedPreferences.getInstance();
        profileList = prefs.getStringList('profiles');
        profileList.add(name);
        prefs.setStringList('profiles', profileList);
        prefs.setString('enabled_profile', name);
    }

    static Future<void> deleteProfile(String name) async {
        final prefs = await SharedPreferences.getInstance();
        profileList.removeWhere((profile) => profile == name);
        prefs.setStringList('profiles', profileList);
        prefs.setString('enabled_profile', enabledProfile);
        //Automation
        prefs.remove('${name}_lidarr');
        prefs.remove('${name}_radarr');
        prefs.remove('${name}_sonarr');
        //Clients
        prefs.remove('${name}_sabnzbd');
        prefs.remove('${name}_nzbget');
    }

    static Future<void> renameProfile(String oldName, String newName) async {
        final prefs = await SharedPreferences.getInstance();
        //Set profile list, enabled_profile
        profileList.add(newName);
        prefs.setStringList('profiles', profileList);
        if(enabledProfile == oldName) {
            enabledProfile = newName;
            prefs.setString('enabled_profile', enabledProfile);
        }
        //Set Automation
        List<String> _sonarr = prefs.getStringList('${oldName}_sonarr');
        List<String> _radarr = prefs.getStringList('${oldName}_radarr');
        List<String> _lidarr = prefs.getStringList('${oldName}_lidarr');
        prefs.setStringList('${newName}_sonarr', _sonarr);
        prefs.setStringList('${newName}_radarr', _radarr);
        prefs.setStringList('${newName}_lidarr', _lidarr);
        //Set Clients
        List<String> _nzbget = prefs.getStringList('${oldName}_nzbget');
        List<String> _sabnzbd = prefs.getStringList('${oldName}_sabnzbd');
        prefs.setStringList('${newName}_nzbget', _nzbget);
        prefs.setStringList('${newName}_sabnzbd', _sabnzbd);
        //Finally delete the old profile
        await deleteProfile(oldName);
    } 

    static Future<void> setProfile(String name) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('enabled_profile', name);
        enabledProfile = name;
        await Configuration.pullValues();
    }
}
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lunasea/configuration/configuration.dart';

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
    }

    static Future<void> setProfile(String name) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('enabled_profile', name);
        enabledProfile = name;
        await Configuration.pullValues();
    }
}
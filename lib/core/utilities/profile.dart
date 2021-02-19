import 'package:lunasea/core.dart';

class LunaProfile {
    /// Safely change profiles.
    /// 
    /// Does this safely by:
    /// - Ensures that the passed in profile isn't already enabled
    /// - Ensures that the profile exists
    Future<bool> safelyChangeProfiles(String profile) async {
        if(LunaDatabaseValue.ENABLED_PROFILE.data != profile) {
            if(Database.profilesBox.containsKey(profile)) {
                LunaDatabaseValue.ENABLED_PROFILE.put(profile);
                LunaState.reset(LunaState.navigatorKey.currentContext);
                showLunaSuccessSnackBar(title: 'Changed Profile', message: profile);
                return true;
            } else {
                LunaLogger().warning('LunaProfile', 'changeProfile', 'Attempted to change profile to unknown profile: $profile');
            }
        }
        return false;
    }
}

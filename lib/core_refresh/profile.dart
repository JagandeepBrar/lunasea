import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaProfile {
    LunaProfile();

    /// Safely change profiles.
    /// 
    /// Does this safely by:
    /// - Ensures that the passed in profile isn't already enabled
    /// - Ensures that the profile exists
    Future<bool> safelyChangeProfiles(BuildContext context, String profile) async {
        if(LunaSeaDatabaseValue.ENABLED_PROFILE.data != profile) {
            if(Database.profilesBox.containsKey(profile)) {
                LunaSeaDatabaseValue.ENABLED_PROFILE.put(profile);
                LunaState.reset(context);
                LSSnackBar(context: context, title: 'Changed Profile', message: profile);
                return true;
            } else {
                LunaLogger().warning('LunaProfile', 'changeProfile', 'Attempted to change profile to unknown profile: $profile');
            }
        }
        return false;
    }
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaProfile {
    LunaProfile._();

    static Future<bool> changeProfile(BuildContext context, String profile) async {
        if(LunaSeaDatabaseValue.ENABLED_PROFILE.data != profile) {
            if(Database.profilesBox.containsKey(profile)) {
                LunaSeaDatabaseValue.ENABLED_PROFILE.put(profile);
                LunaProvider.reset(context);
                LSSnackBar(context: context, title: 'Changed Profile', message: profile);
                return true;
            } else {
                LunaLogger.warning('LunaProfile', 'changeProfile', 'Attempted to change profile to unknown profile: $profile');
            }
        }
        return false;
    }
}

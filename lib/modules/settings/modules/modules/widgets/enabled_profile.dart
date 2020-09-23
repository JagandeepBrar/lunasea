import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesEnabledProfileButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSIconButton(
        icon: Icons.person,
        onPressed: () async => _changeProfile(context),
    );

    Future<void> _changeProfile(BuildContext context) async {
        List<dynamic> values = await SettingsDialogs.enabledProfile(
            context,
            Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
        );
        if(values[0] && values[1] != LunaSeaDatabaseValue.ENABLED_PROFILE.data)
            LunaSeaDatabaseValue.ENABLED_PROFILE.put(values[1]);
    }
}

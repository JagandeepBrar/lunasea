import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsProfileEnabledTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Enabled Profile'),
        subtitle: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.ENABLED_PROFILE.key]),
            builder: (context, box, widget) => LSSubtitle(text: box.get(LunaDatabaseValue.ENABLED_PROFILE.key)),
        ),
        trailing: LSIconButton(icon: Icons.person),
        onTap: () => _changeProfile(context),
    );

    Future<void> _changeProfile(BuildContext context) async {
        List<dynamic> values = await SettingsDialogs.enabledProfile(
            context,
            Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
        );
        if(values[0] && values[1] != LunaDatabaseValue.ENABLED_PROFILE.data)
            LunaProfile().safelyChangeProfiles(context, values[1]);
    }
}

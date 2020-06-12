import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsGeneralEnabledProfileTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Enabled Profile'),
        subtitle: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.ENABLED_PROFILE.key]),
            builder: (context, box, widget) => LSSubtitle(text: box.get(LunaSeaDatabaseValue.ENABLED_PROFILE.key)),
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () => _changeProfile(context),
    );

    Future<void> _changeProfile(BuildContext context) async {
        List<dynamic> values = await LSDialogSettings.enabledProfile(
            context,
            Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
        );
        if(values[0]) {
            if(values[1] != Database.lunaSeaBox.get(LunaSeaDatabaseValue.ENABLED_PROFILE.key)) {
                Database.lunaSeaBox.put(LunaSeaDatabaseValue.ENABLED_PROFILE.key, values[1]);
            }
        }
    }
}

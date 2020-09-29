import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsModulesSonarrEnableVersion3Tile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Sonarr v3 Features'),
        subtitle: LSSubtitle(text: 'Enable Version 3 Specific Features',),
        trailing: Switch(
            value: Database.currentProfileObject.sonarrVersion3 ?? false,
            onChanged: (value) {
                Database.currentProfileObject.sonarrVersion3 = value;
                Database.currentProfileObject.save();
                Provider.of<SonarrState>(context, listen: false).reset();
            },
        ),
    );
}

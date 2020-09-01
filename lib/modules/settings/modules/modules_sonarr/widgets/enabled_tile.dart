import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesSonarrEnabledTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Enable Sonarr'),
        trailing: Switch(
            value: Database.currentProfileObject.sonarrEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.sonarrEnabled = value;
                Database.currentProfileObject.save(context: context);
            },
        ),
    );
}
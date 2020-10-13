import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesRadarrEnabledTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Enable Radarr'),
        trailing: Switch(
            value: Database.currentProfileObject.radarrEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.radarrEnabled = value;
                Database.currentProfileObject.save();
            },
        ),
    );
}
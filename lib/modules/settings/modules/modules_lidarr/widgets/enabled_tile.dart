import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesLidarrEnabledTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Enable Lidarr'),
        trailing: Switch(
            value: Database.currentProfileObject.lidarrEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.lidarrEnabled = value;
                Database.currentProfileObject.save(context: context);
            },
        ),
    );
}
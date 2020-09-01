import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesWakeOnLANEnabledTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Enable Wake on LAN'),
        trailing: Switch(
            value: Database.currentProfileObject.wakeOnLANEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.wakeOnLANEnabled = value;
                Database.currentProfileObject.save(context: context);
            },
        ),
    );
}
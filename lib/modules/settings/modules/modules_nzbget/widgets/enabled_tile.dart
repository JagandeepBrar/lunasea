import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesNZBGetEnabledTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Enable NZBGet'),
        trailing: Switch(
            value: Database.currentProfileObject.nzbgetEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.nzbgetEnabled = value;
                Database.currentProfileObject.save(context: context);
            },
        ),
    );
}
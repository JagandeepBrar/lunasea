import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesTautulliEnabledTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Enable Tautulli'),
        trailing: Switch(
            value: Database.currentProfileObject.tautulliEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.tautulliEnabled = value;
                Database.currentProfileObject.save(context: context);
            },
        ),
    );
}
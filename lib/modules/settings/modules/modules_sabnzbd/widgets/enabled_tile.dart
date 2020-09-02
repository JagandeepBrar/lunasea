import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesSABnzbdEnabledTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Enable SABnzbd'),
        trailing: Switch(
            value: Database.currentProfileObject.sabnzbdEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.sabnzbdEnabled = value;
                Database.currentProfileObject.save(context: context);
            },
        ),
    );
}
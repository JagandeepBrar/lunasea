import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsModulesCalendarEnableRadarrTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_ENABLE_RADARR.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Radarr in Calendar'),
            subtitle: LSSubtitle(text: 'Show Radarr calendar entries'),
            trailing: Switch(
                value: HomeDatabaseValue.CALENDAR_ENABLE_RADARR.data,
                onChanged: _changeState,
            ),
        ),
    );

    void _changeState(bool value) => HomeDatabaseValue.CALENDAR_ENABLE_RADARR.put(value);
}

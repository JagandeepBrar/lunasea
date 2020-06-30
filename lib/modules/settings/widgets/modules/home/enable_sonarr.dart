import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsModulesCalendarEnableSonarrTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_ENABLE_SONARR.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Sonarr'),
            subtitle: LSSubtitle(text: HomeDatabaseValue.CALENDAR_ENABLE_SONARR.data
                ? 'Showing Sonarr Entries'
                : 'Hiding Sonarr Entries'
            ),
            trailing: Switch(
                value: HomeDatabaseValue.CALENDAR_ENABLE_SONARR.data,
                onChanged: _changeState,
            ),
        ),
    );

    void _changeState(bool value) => HomeDatabaseValue.CALENDAR_ENABLE_SONARR.put(value);
}

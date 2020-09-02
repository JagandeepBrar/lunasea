import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsCustomizationCalendarEnableSonarrTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_ENABLE_SONARR.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Show Sonarr'),
            subtitle: LSSubtitle(text: 'Show Sonarr Calendar Entries'),
            trailing: Switch(
                value: HomeDatabaseValue.CALENDAR_ENABLE_SONARR.data,
                onChanged: _changeState,
            ),
        ),
    );

    void _changeState(bool value) => HomeDatabaseValue.CALENDAR_ENABLE_SONARR.put(value);
}

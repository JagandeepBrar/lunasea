import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsModulesCalendarEnableLidarrTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Lidarr'),
            subtitle: LSSubtitle(text: HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.data
                ? 'Showing Lidarr Entries'
                : 'Hiding Lidarr Entries'
            ),
            trailing: Switch(
                value: HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.data,
                onChanged: _changeState,
            ),
        ),
    );

    void _changeState(bool value) => HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.put(value);
}

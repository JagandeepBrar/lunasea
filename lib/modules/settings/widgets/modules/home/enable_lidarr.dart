import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsModulesCalendarEnableLidarrTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Lidarr in Calendar'),
            subtitle: LSSubtitle(text: 'Show Lidarr calendar entries'),
            trailing: Switch(
                value: HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.data,
                onChanged: _changeState,
            ),
        ),
    );

    void _changeState(bool value) => HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.put(value);
}

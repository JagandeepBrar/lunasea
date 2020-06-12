import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesCalendarStartingDateTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_STARTING_DAY.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Starting Day of Week'),
            subtitle: LSSubtitle(text: (HomeDatabaseValue.CALENDAR_STARTING_DAY.data as CalendarStartingDay).name),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => _changeDate(context),
        ),
    );

    Future<void> _changeDate(BuildContext context) async {
        List _values = await LSDialogSettings.editCalendarStartingDay(context);
        if(_values[0]) Database.lunaSeaBox.put(
            HomeDatabaseValue.CALENDAR_STARTING_DAY.key,
            _values[1],
        );
    }
}
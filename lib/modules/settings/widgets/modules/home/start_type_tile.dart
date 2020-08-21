import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesHomeCalendarStartingTypeTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_STARTING_TYPE.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Starting Type'),
            subtitle: LSSubtitle(text: (HomeDatabaseValue.CALENDAR_STARTING_TYPE.data as CalendarStartingType).name),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => _changeType(context),
        ),
    );

    Future<void> _changeType(BuildContext context) async {
        List _values = await SettingsDialogs.editCalendarStartingType(context);
        if(_values[0]) HomeDatabaseValue.CALENDAR_STARTING_TYPE.put(_values[1]);
    }
}

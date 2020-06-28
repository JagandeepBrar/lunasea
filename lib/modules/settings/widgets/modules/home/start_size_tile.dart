import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesHomeCalendarStartingSizeTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_STARTING_SIZE.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Calendar Starting Size'),
            subtitle: LSSubtitle(text: (HomeDatabaseValue.CALENDAR_STARTING_SIZE.data as CalendarStartingSize).name),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => _changeSize(context),
        ),
    );

    Future<void> _changeSize(BuildContext context) async {
        List _values = await SettingsDialogs.editCalendarStartingSize(context);
        if(_values[0]) HomeDatabaseValue.CALENDAR_STARTING_SIZE.put(_values[1]);
    }
}
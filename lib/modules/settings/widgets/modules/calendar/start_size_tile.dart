import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsModulesCalendarStartingSizeTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_STARTING_SIZE.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Starting Size'),
            subtitle: LSSubtitle(text: (HomeDatabaseValue.CALENDAR_STARTING_SIZE.data as CalendarStartingSize).name),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => _changeSize(context),
        ),
    );

    Future<void> _changeSize(BuildContext context) async {
        List _values = await LSDialogSettings.editCalendarStartingSize(context);
        if(_values[0]) Database.lunaSeaBox.put(
            HomeDatabaseValue.CALENDAR_STARTING_SIZE.key,
            _values[1],
        );
    }
}
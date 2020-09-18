import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsCustomizationCalendarPastDaysTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_DAYS_PAST.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Past Days'),
            subtitle: LSSubtitle(text: HomeDatabaseValue.CALENDAR_DAYS_PAST.data == 1
                ? '1 Day'
                : '${HomeDatabaseValue.CALENDAR_DAYS_PAST.data} Days',
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => _onTap(context),
        ),
    );

    Future<void> _onTap(BuildContext context) async {
        List _values = await HomeDialogs.setPastDays(context);
        if(_values[0]) HomeDatabaseValue.CALENDAR_DAYS_PAST.put(_values[1]);
    }
}

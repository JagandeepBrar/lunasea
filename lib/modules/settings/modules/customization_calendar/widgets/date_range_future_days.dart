import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsCustomizationCalendarFutureDaysTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_DAYS_FUTURE.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Future Days'),
            subtitle: LSSubtitle(text: HomeDatabaseValue.CALENDAR_DAYS_FUTURE.data == 1
                ? '1 Day'
                : '${HomeDatabaseValue.CALENDAR_DAYS_FUTURE.data} Days',
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => _onTap(context),
        ),
    );

    Future<void> _onTap(BuildContext context) async {
        List _values = await HomeDialogs.setFutureDays(context);
        if(_values[0]) HomeDatabaseValue.CALENDAR_DAYS_FUTURE.put(_values[1]);
    }
}

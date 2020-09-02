import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsCustomizationDrawerExpandMonitoringTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Monitoring'),
            subtitle: LSSubtitle(text: 'Expand the Monitoring Category Initially'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING.data,
                onChanged: _onChange,
            ),
        ),
    );

    void _onChange(bool value) => LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING.put(value);
}

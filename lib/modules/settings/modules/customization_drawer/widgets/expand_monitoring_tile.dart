import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsCustomizationDrawerExpandMonitoringTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING.key,
            LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.key,
        ]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Monitoring'),
            subtitle: LSSubtitle(text: 'Expand Monitoring Category Initially'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING.data,
                onChanged: LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.data
                    ? _onChange
                    : null,
            ),
        ),
    );

    void _onChange(bool value) => LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING.put(value);
}

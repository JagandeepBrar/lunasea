import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsCustomizationAppearance24HourTimeTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.USE_24_HOUR_TIME.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Use 24 Hour Time'),
            subtitle: LSSubtitle(text: 'Show Timestamps in 24 Hour Style'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.USE_24_HOUR_TIME.data,
                onChanged: _changeState,
            ),
        ),
    );

    void _changeState(bool value) => LunaSeaDatabaseValue.USE_24_HOUR_TIME.put(value);
}

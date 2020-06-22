import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesLunaSeaAMOLEDBorderTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.THEME_AMOLED_BORDER.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'AMOLED Borders'),
            subtitle: LSSubtitle(text: 'Add Subtle Borders Across UI'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data,
                onChanged: _changeState,
            ),
        ),
    );

    void _changeState(bool value) => LunaSeaDatabaseValue.THEME_AMOLED_BORDER.put(value);
}
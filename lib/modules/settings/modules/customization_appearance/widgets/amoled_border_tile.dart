import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsCustomizationAppearanceAMOLEDBorderTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaSeaDatabaseValue.THEME_AMOLED_BORDER.key,
            LunaSeaDatabaseValue.THEME_AMOLED.key,
        ]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'AMOLED Borders'),
            subtitle: LSSubtitle(text: 'Add Subtle Borders Across UI'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data,
                onChanged: LunaSeaDatabaseValue.THEME_AMOLED.data
                    ? _changeState
                    : null,
            ),
        ),
    );

    void _changeState(bool value) => LunaSeaDatabaseValue.THEME_AMOLED_BORDER.put(value);
}
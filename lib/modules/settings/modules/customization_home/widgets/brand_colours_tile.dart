import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsCustomizationHomeBrandColoursTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.MODULES_BRAND_COLOURS.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Use Brand Colours'),
            subtitle: LSSubtitle(text: 'Use the brand colours for the icons'),
            trailing: Switch(
                value: HomeDatabaseValue.MODULES_BRAND_COLOURS.data,
                onChanged: (value) => HomeDatabaseValue.MODULES_BRAND_COLOURS.put(value),
            ),
        ),
    );
}

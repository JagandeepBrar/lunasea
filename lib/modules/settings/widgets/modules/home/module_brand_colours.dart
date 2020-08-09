import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class SettingsModulesHomeBrandColours extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.MODULES_BRAND_COLOURS.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Use Brand Colours'),
            subtitle: LSSubtitle(
                text: HomeDatabaseValue.MODULES_BRAND_COLOURS.data
                    ? 'Using module brand colours'
                    : 'Using LunaSea list colours',
            ),
            trailing: Switch(
                value: HomeDatabaseValue.MODULES_BRAND_COLOURS.data,
                onChanged: (value) => HomeDatabaseValue.MODULES_BRAND_COLOURS.put(value),
            ),
        ),
    );
}

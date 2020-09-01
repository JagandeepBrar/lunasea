import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SettingsCustomizationSearchHideAdultCategoriesTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SearchDatabaseValue.HIDE_XXX.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Hide Adult Categories'),
            subtitle: LSSubtitle(text: 'Hide Categories Containing Adult Content'),
            trailing: Switch(
                value: SearchDatabaseValue.HIDE_XXX.data,
                onChanged: (value) => SearchDatabaseValue.HIDE_XXX.put(value),
            ),
        ),
    );
}

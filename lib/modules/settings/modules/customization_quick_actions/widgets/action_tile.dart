import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsCustomizationQuickActionTile extends StatelessWidget {
    final String title;
    final LunaSeaDatabaseValue action;

    SettingsCustomizationQuickActionTile({
        Key key,
        @required this.title,
        @required this.action,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: title),
        trailing: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [action.key]),
            builder: (context, box, _) => Switch(
                value: action.data,
                onChanged: (value) {
                    action.put(value);
                    HomescreenActions.setShortcutItems();
                }
            ),
        ),
    );
}
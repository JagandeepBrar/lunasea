import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliDialogs {
    static Future<List<dynamic>> globalSettings(BuildContext context) async {
        bool _flag = false;
        TautulliGlobalSettingsType _value;
        
        void _setValues(bool flag, TautulliGlobalSettingsType value) {
            _flag = flag;
            _value = value;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Tautulli Settings',
            content: List.generate(
                TautulliGlobalSettingsType.values.length,
                (index) => LSDialog.tile(
                    text: TautulliGlobalSettingsType.values[index].name,
                    icon: TautulliGlobalSettingsType.values[index].icon,
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, TautulliGlobalSettingsType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> defaultPage(BuildContext context) async {
        bool _flag = false;
        int _index = 0;

        void _setValues(bool flag, int index) {
            _flag = flag;
            _index = index;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Default Page',
            content: List.generate(
                TautulliNavigationBar.titles.length,
                (index) => LSDialog.tile(
                    text: TautulliNavigationBar.titles[index],
                    icon: TautulliNavigationBar.icons[index],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, index),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );

        return [_flag, _index];
    }
}
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDialogs {
    RadarrDialogs._();

    static Future<List<dynamic>> globalSettings(BuildContext context) async {
        bool _flag = false;
        RadarrGlobalSettingsType _value;
        
        void _setValues(bool flag, RadarrGlobalSettingsType value) {
            _flag = flag;
            _value = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Radarr Settings',
            content: List.generate(
                RadarrGlobalSettingsType.values.length,
                (index) => LSDialog.tile(
                    text: RadarrGlobalSettingsType.values[index].name,
                    icon: RadarrGlobalSettingsType.values[index].icon,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, RadarrGlobalSettingsType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }
}

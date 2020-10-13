import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesLidarrAPIKeyTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'API Key'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.lidarrKey == null || Database.currentProfileObject.lidarrKey == ''
                ? 'Not Set'
                : '••••••••••••'
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeKey(context),
    );

    Future<void> _changeKey(BuildContext context) async {
        List<dynamic> _values = await LunaDialogs.editText(
            context,
            'Lidarr API Key',
            prefill: Database.currentProfileObject.lidarrKey ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.lidarrKey = _values[1];
            Database.currentProfileObject.save();
        }
    }
}

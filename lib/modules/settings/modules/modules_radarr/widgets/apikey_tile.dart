import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesRadarrAPIKeyTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'API Key'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.radarrKey == null || Database.currentProfileObject.radarrKey == ''
                ? 'Not Set'
                : '••••••••••••'
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeKey(context),
    );

    Future<void> _changeKey(BuildContext context) async {
        List<dynamic> _values = await LunaDialogs.editText(
            context,
            'Radarr API Key',
            prefill: Database.currentProfileObject.radarrKey ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.radarrKey = _values[1];
            Database.currentProfileObject.save(context: context);
        }
    }
}
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesSonarrAPIKeyTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'API Key'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.sonarrKey == null || Database.currentProfileObject.sonarrKey == ''
                ? 'Not Set'
                : '••••••••••••'
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeKey(context),
    );

    Future<void> _changeKey(BuildContext context) async {
        List<dynamic> _values = await LunaDialogs.editText(
            context,
            'Sonarr API Key',
            prefill: Database.currentProfileObject.sonarrKey ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.sonarrKey = _values[1];
            Database.currentProfileObject.save(context: context);
        }
    }
}
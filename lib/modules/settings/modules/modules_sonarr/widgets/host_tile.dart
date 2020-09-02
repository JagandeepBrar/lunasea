import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSonarrHostTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Host'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.sonarrHost == null || Database.currentProfileObject.sonarrHost == ''
                ? 'Not Set'
                : Database.currentProfileObject.sonarrHost
            ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeHost(context),
    );

    Future<void> _changeHost(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.editHost(
            context,
            'Sonarr Host',
            prefill: Database.currentProfileObject.sonarrHost ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.sonarrHost = _values[1];
            Database.currentProfileObject.save(context: context);
        }
    }
}
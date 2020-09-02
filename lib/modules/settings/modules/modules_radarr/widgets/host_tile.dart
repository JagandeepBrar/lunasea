import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesRadarrHostTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Host'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.radarrHost == null || Database.currentProfileObject.radarrHost == ''
                ? 'Not Set'
                : Database.currentProfileObject.radarrHost
            ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeHost(context),
    );

    Future<void> _changeHost(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.editHost(
            context,
            'Radarr Host',
            prefill: Database.currentProfileObject.radarrHost ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.radarrHost = _values[1];
            Database.currentProfileObject.save(context: context);
        }
    }
}
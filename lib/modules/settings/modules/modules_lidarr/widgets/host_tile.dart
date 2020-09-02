import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesLidarrHostTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Host'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.lidarrHost == null || Database.currentProfileObject.lidarrHost == ''
                ? 'Not Set'
                : Database.currentProfileObject.lidarrHost
            ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeHost(context),
    );

    Future<void> _changeHost(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.editHost(
            context,
            'Lidarr Host',
            prefill: Database.currentProfileObject.lidarrHost ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.lidarrHost = _values[1];
            Database.currentProfileObject.save(context: context);
        }
    }
}
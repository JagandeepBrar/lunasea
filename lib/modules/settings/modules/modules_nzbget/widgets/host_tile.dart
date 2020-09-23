import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesNZBGetHostTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Host'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.nzbgetHost == null || Database.currentProfileObject.nzbgetHost == ''
                ? 'Not Set'
                : Database.currentProfileObject.nzbgetHost
            ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeHost(context),
    );

    Future<void> _changeHost(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.editHost(
            context,
            'NZBGet Host',
            prefill: Database.currentProfileObject.nzbgetHost ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.nzbgetHost = _values[1];
            Database.currentProfileObject.save();
        }
    }
}
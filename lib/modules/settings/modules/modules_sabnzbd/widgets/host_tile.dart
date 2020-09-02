import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSABnzbdHostTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Host'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.sabnzbdHost == null || Database.currentProfileObject.sabnzbdHost == ''
                ? 'Not Set'
                : Database.currentProfileObject.sabnzbdHost
            ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeHost(context),
    );

    Future<void> _changeHost(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.editHost(
            context,
            'SABnzbd Host',
            prefill: Database.currentProfileObject.sabnzbdHost ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.sabnzbdHost = _values[1];
            Database.currentProfileObject.save(context: context);
        }
    }
}
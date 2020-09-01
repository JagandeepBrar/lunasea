import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesTautulliHostTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Host'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.tautulliHost == null || Database.currentProfileObject.tautulliHost == ''
                ? 'Not Set'
                : Database.currentProfileObject.tautulliHost
            ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeHost(context),
    );

    Future<void> _changeHost(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.editHost(
            context,
            'Tautulli Host',
            prefill: Database.currentProfileObject.tautulliHost ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.tautulliHost = _values[1];
            Database.currentProfileObject.save(context: context);
        }
    }
}
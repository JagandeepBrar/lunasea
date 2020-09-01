import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesNZBGetUsernameTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Username'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.nzbgetUser == null || Database.currentProfileObject.nzbgetUser == ''
                ? 'Not Set'
                : Database.currentProfileObject.nzbgetUser
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeUsername(context),
    );

    Future<void> _changeUsername(BuildContext context) async {
        List<dynamic> _values = await GlobalDialogs.editText(
            context,
            'NZBGet Username',
            prefill: Database.currentProfileObject.nzbgetUser ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.nzbgetUser = _values[1];
            Database.currentProfileObject.save(context: context);
        }
    }
}

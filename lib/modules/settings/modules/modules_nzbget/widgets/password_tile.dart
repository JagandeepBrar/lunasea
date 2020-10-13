import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesNZBGetPasswordTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Password'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.nzbgetPass == null || Database.currentProfileObject.nzbgetPass == ''
                ? 'Not Set'
                : '••••••••••••'
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changePassword(context),
    );

    Future<void> _changePassword(BuildContext context) async {
        List<dynamic> _values = await LunaDialogs.editText(
            context,
            'NZBGet Password',
            prefill: Database.currentProfileObject.nzbgetPass ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.nzbgetPass = _values[1];
            Database.currentProfileObject.save();
        }
    }
}
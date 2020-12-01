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
            extraText: [
                LSDialog.textSpanContent(text: '${Constants.TEXT_BULLET}\tIf your password includes special characters, considering adding a '),
                LSDialog.bolded(text: 'basic authentication'),
                LSDialog.textSpanContent(text: ' header with your username and password instead for better support'),
            ],
        );
        if(_values[0]) {
            Database.currentProfileObject.nzbgetPass = _values[1];
            Database.currentProfileObject.save();
        }
    }
}
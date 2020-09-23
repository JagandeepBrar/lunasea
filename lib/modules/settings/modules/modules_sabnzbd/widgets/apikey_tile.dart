import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesSABnzbdAPIKeyTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'API Key'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.sabnzbdKey == null || Database.currentProfileObject.sabnzbdKey == ''
                ? 'Not Set'
                : '••••••••••••'
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeKey(context),
    );

    Future<void> _changeKey(BuildContext context) async {
        List<dynamic> _values = await LunaDialogs.editText(
            context,
            'SABnzbd API Key',
            prefill: Database.currentProfileObject.sabnzbdKey ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.sabnzbdKey = _values[1];
            Database.currentProfileObject.save();
        }
    }
}
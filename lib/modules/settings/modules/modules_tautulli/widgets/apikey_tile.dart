import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsModulesTautulliAPIKeyTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'API Key'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.tautulliKey == null || Database.currentProfileObject.tautulliKey == ''
                ? 'Not Set'
                : '••••••••••••'
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeKey(context),
    );

    Future<void> _changeKey(BuildContext context) async {
        List<dynamic> _values = await LunaDialogs.editText(
            context,
            'Tautulli API Key',
            prefill: Database.currentProfileObject.tautulliKey ?? '',
        );
        if(_values[0]) {
            Database.currentProfileObject.tautulliKey = _values[1];
            Database.currentProfileObject.save();
            Provider.of<TautulliState>(context, listen: false).reset();
        }
    }
}
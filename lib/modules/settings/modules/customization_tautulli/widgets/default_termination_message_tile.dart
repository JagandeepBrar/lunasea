import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsCustomizationTautulliDefaultTerminationMessageTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.TERMINATION_MESSAGE.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Default Termination Message'),
            subtitle: LSSubtitle(
                text: (TautulliDatabaseValue.TERMINATION_MESSAGE.data as String).isEmpty
                    ? 'Not Set'
                    : TautulliDatabaseValue.TERMINATION_MESSAGE.data,
            ),
            trailing: LSIconButton(icon: Icons.stop),
            onTap: () async => _onTap(context),
        ),
    );

    Future<void> _onTap(BuildContext context) async {
        List<dynamic> _values = await TautulliDialogs.setTerminationMessage(context);
        if(_values[0]) TautulliDatabaseValue.TERMINATION_MESSAGE.put(_values[1]);
    }
}

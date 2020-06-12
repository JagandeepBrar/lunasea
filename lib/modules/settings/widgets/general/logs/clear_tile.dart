import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsGeneralClearLogsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Clear Logs'),
        subtitle: LSSubtitle(text: 'Clear All Recorded Logs'),
        trailing: LSIconButton(icon: Icons.delete),
        onTap: () async => _clearLogs(context),
    );

    Future<void> _clearLogs(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.clearLogs(context);
        if(_values[0]) {
            Logger.clearLogs();
            LSSnackBar(context: context, title: 'Logs Cleared', message: 'All recorded logs have been cleared', type: SNACKBAR_TYPE.success);
        }
    }
}

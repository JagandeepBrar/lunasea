import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsLogsExportTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Export'),
        subtitle: LSSubtitle(text: 'Export All Recorded Logs'),
        trailing: LSIconButton(icon: Icons.file_download),
        onTap: () async => _exportLogs(context),
    );

    Future<void> _exportLogs(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.exportLogs(context);
        if(_values[0]) {
            LunaLogger.exportLogs();
            LSSnackBar(context: context, title: 'Exported Logs', message: 'Logs are located in the application directory', type: SNACKBAR_TYPE.success);
        }
    }
}

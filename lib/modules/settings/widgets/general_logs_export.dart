import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsGeneralExportLogsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Export Logs'),
        subtitle: LSSubtitle(text: 'Export all recorded logs'),
        trailing: LSIconButton(icon: Icons.file_download),
        onTap: () async => _exportLogs(context),
    );

    Future<void> _exportLogs(BuildContext context) async {
        List<dynamic> _values = await LSDialogSettings.exportLogs(context);
        if(_values[0]) {
            Logger.exportLogs();
            LSSnackBar(context: context, title: 'Exported Logs', message: 'Logs are located in the application directory', type: SNACKBAR_TYPE.success);
        }
    }
}

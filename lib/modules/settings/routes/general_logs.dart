import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../settings.dart';

class SettingsGeneralLogs extends StatefulWidget {
    @override
    State<SettingsGeneralLogs> createState() => _State();
}

class _State extends State<SettingsGeneralLogs> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
    );

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'View Logs'),
                subtitle: LSSubtitle(text: 'View all recorded logs'),
                trailing: LSIconButton(icon: Icons.developer_mode),
                onTap: _viewLogs,
            ),
            LSDivider(),
            LSCardTile(
                title: LSTitle(text: 'Export Logs'),
                subtitle: LSSubtitle(text: 'Export all recorded logs'),
                trailing: LSIconButton(icon: Icons.file_download),
                onTap: _exportLogs,
            ),
            LSCardTile(
                title: LSTitle(text: 'Clear Logs'),
                subtitle: LSSubtitle(text: 'Clear all recorded logs'),
                trailing: LSIconButton(icon: Icons.delete),
                onTap: _deleteLogs,
            ),
        ],
    );

    Future<void> _viewLogs() async => Navigator.of(context).pushNamed(SettingsGeneralLogsTypes.ROUTE_NAME);

    Future<void> _exportLogs() async {
        List<dynamic> _values = await LSDialogSettings.exportLogs(context);
        if(_values[0]) {
            Logger.exportLogs();
            LSSnackBar(context: context, title: 'Exported Logs', message: 'Logs are located in the application directory', type: SNACKBAR_TYPE.success);
        }
    }

    Future<void> _deleteLogs() async {
        List<dynamic> _values = await LSDialogSettings.clearLogs(context);
        if(_values[0]) {
            Logger.clearLogs();
            LSSnackBar(context: context, title: 'Logs Cleared', message: 'All recorded logs have been cleared', type: SNACKBAR_TYPE.success);
        }
    }
}

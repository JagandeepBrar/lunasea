import 'package:flutter/material.dart';
import 'package:lunasea/routes/settings/routes.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/widgets/ui.dart';

class SettingsGeneralLogs extends StatefulWidget {
    @override
    State<SettingsGeneralLogs> createState() => _State();
}

class _State extends State<SettingsGeneralLogs> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => LSListView(
        children: <Widget>[
            LSCard(
                title: LSTitle(text: 'View Logs'),
                subtitle: LSSubtitle(text: 'View all recorded logs'),
                trailing: LSIconButton(icon: Icons.developer_mode),
                onTap: _viewLogs,
            ),
            LSDivider(),
            LSCard(
                title: LSTitle(text: 'Export Logs'),
                subtitle: LSSubtitle(text: 'Export all recorded logs'),
                trailing: LSIconButton(icon: Icons.file_download),
                onTap: _exportLogs,
            ),
            LSCard(
                title: LSTitle(text: 'Clear Logs'),
                subtitle: LSSubtitle(text: 'Clear all recorded logs'),
                trailing: LSIconButton(icon: Icons.delete),
                onTap: _deleteLogs,
            ),
        ],
    );

    Future<void> _viewLogs() async => Navigator.of(context).pushNamed(SettingsGeneralLogsTypes.ROUTE_NAME);

    Future<void> _exportLogs() async {
        List<dynamic> _values = await SystemDialogs.showExportLogsPrompt(context);
        if(_values[0]) {
            Logger.exportLogs();
            Notifications.showSnackBar(_scaffoldKey, 'Exported recorded logs to the filesystem');
        }
    }

    Future<void> _deleteLogs() async {
        List<dynamic> _values = await SystemDialogs.showClearLogsPrompt(context);
        if(_values[0]) {
            Logger.clearLogs();
            Notifications.showSnackBar(_scaffoldKey, 'All recorded logs have been cleared');
        }
    }
}

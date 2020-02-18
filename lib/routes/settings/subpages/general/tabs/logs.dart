import 'package:flutter/material.dart';
import 'package:lunasea/routes/settings/subpages/general/tabs/logs/type.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/widgets/ui.dart';

class Logs extends StatefulWidget {
    @override
    State<Logs> createState() {
        return _State();
    }
}

class _State extends State<Logs> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _build(),
        );
    }

    Widget _build() {
        return LSListView(
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
    }

    Future<void> _viewLogs() async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => TypeLogs(),
            ),
        );
    }

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

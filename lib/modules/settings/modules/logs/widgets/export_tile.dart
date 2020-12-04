import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:share/share.dart';

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
            File _logs = await LunaLogger.exportLogs();
            Share.shareFiles([_logs.path]);
        }
    }
}

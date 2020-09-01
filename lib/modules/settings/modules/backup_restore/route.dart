import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsBackupRestoreRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/backup_restore';

    @override
    State<SettingsBackupRestoreRoute> createState() => _State();
}

class _State extends State<SettingsBackupRestoreRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Backup & Restore');

    Widget get _body => LSListView(
        children: [
            SettingsBackupRestoreBackupTile(),
            SettingsBackupRestoreRestoreTile(),
        ],
    );
}

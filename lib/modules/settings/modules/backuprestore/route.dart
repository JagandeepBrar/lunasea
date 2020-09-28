import 'package:flutter/material.dart' hide Router;
import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsBackupRestoreRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/backuprestore';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsBackupRestoreRoute()),
        transitionType: LunaRouter.transitionType,
    );

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

    Widget get _appBar => LunaAppBar(
        context: context,
        popUntil: '/settings',
        title: 'Backup & Restore',
    );

    Widget get _body => LSListView(
        children: [
            SettingsBackupRestoreBackupTile(),
            SettingsBackupRestoreRestoreTile(),
        ],
    );
}

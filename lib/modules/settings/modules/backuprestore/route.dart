import 'package:flutter/material.dart' hide Router;
import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsBackupRestoreRouter {
    static const ROUTE_NAME = '/settings/backuprestore';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsBackupRestoreRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsBackupRestoreRouter._();
}

class _SettingsBackupRestoreRoute extends StatefulWidget {
    @override
    State<_SettingsBackupRestoreRoute> createState() => _State();
}

class _State extends State<_SettingsBackupRestoreRoute> {
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

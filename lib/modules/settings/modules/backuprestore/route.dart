import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsBackupRestoreRouter extends LunaPageRouter {
    static const ROUTE_NAME = '/settings/backuprestore';

    Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        ROUTE_NAME,
    );

    String route(List parameters) => ROUTE_NAME;

    void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _Widget()),
        transitionType: LunaRouter.transitionType,
    );
}

class _Widget extends StatefulWidget {
    @override
    State<_Widget> createState() => _State();
}

class _State extends State<_Widget> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Backup & Restore',
    );

    Widget get _body => LSListView(
        children: [
            SettingsBackupRestoreBackupTile(),
            SettingsBackupRestoreRestoreTile(),
        ],
    );
}

import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:share/share.dart';

class SettingsSystemLogsRouter extends LunaPageRouter {
    static const ROUTE_NAME = '/settings/logs';

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
        title: 'Logs',
    );

    Widget get _body => LSListView(
        children: [
            LSCardTile(
                title: LSTitle(text: 'All Logs'),
                subtitle: LSSubtitle(text: 'View Logs of All Types'),
                trailing: LSIconButton(icon: Icons.developer_mode),
                onTap: () async => _viewLogs('All'),
            ),
            LSCardTile(
                title: LSTitle(text: 'Warning'),
                subtitle: LSSubtitle(text: 'View Warning Logs'),
                trailing: LSIconButton(icon: Icons.warning),
                onTap: () async => _viewLogs('Warning'),
            ),
            LSCardTile(
                title: LSTitle(text: 'Error'),
                subtitle: LSSubtitle(text: 'View Error Logs'),
                trailing: LSIconButton(icon: Icons.report),
                onTap: () async => _viewLogs('Error'),
            ),
            LSCardTile(
                title: LSTitle(text: 'Fatal'),
                subtitle: LSSubtitle(text: 'View Fatal Logs'),
                trailing: LSIconButton(icon: Icons.new_releases),
                onTap: () async => _viewLogs('Fatal'),
            ),
            LSDivider(),
            _exportTile,
            _clearTile,
        ]
    );

    Future<void> _viewLogs(String type) async => SettingsSystemLogsDetailsRouter().navigateTo(
        context,
        type: type,
    );

    Widget get _clearTile {
        // Execute action
        Future<void> _execute() async {
            List _values = await SettingsDialogs.clearLogs(context);
            if(_values[0]) {
                LunaLogger.clearLogs();
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Logs Cleared',
                    message: 'All recorded logs have been cleared',
                );
            }
        }
        // Tile
        return LSCardTile(
            title: LSTitle(text: 'Clear'),
            subtitle: LSSubtitle(text: 'Clear All Recorded Logs'),
            trailing: LSIconButton(icon: Icons.delete),
            onTap: _execute,
        );
    }

    Widget get _exportTile {
        // Execute action
        Future<void> _execute() async {
            List<dynamic> _values = await SettingsDialogs.exportLogs(context);
            if(_values[0]) {
                File _logs = await LunaLogger.exportLogs();
                Share.shareFiles([_logs.path]);
            }
        }
        // Tile
        return LSCardTile(
            title: LSTitle(text: 'Export'),
            subtitle: LSSubtitle(text: 'Export All Recorded Logs'),
            trailing: LSIconButton(icon: Icons.file_download),
            onTap: _execute,
        );
    }
}

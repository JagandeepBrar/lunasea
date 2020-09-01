import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsLogsRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/logs';

    @override
    State<SettingsLogsRoute> createState() => _State();
}

class _State extends State<SettingsLogsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Logs');

    Widget get _body => LSListView(
        children: [
            ..._logs,
            LSDivider(),
            ..._other,
        ],
    );

    List<Widget> get _logs => [
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
    ];

    List<Widget> get _other => [
        SettingsLogsExportTile(),
        SettingsLogsClearTile(),
    ];

    Future<void> _viewLogs(String type) async => Navigator.of(context).pushNamed(
        SettingsLogsDetailsRoute.ROUTE_NAME,
        arguments: SettingsLogsDetailsRouteArguments(type: type),
    );
}
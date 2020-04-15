import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../../settings.dart';

class SettingsGeneralLogsTypes extends StatefulWidget {
    static const ROUTE_NAME = '/settings/general/logs/types';

    @override
    State<SettingsGeneralLogsTypes> createState() => _State();
}

class _State extends State<SettingsGeneralLogsTypes> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Log Types');

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'All Logs'),
                subtitle: LSSubtitle(text: 'View logs of all types'),
                trailing: LSIconButton(icon: Icons.developer_mode),
                onTap: () async => _viewLogs('All'),
            ),
            LSDivider(),
            LSCardTile(
                title: LSTitle(text: 'Warning'),
                subtitle: LSSubtitle(text: 'View warning logs'),
                trailing: LSIconButton(icon: Icons.warning),
                onTap: () async => _viewLogs('Warning'),
            ),
            LSCardTile(
                title: LSTitle(text: 'Error'),
                subtitle: LSSubtitle(text: 'View error logs'),
                trailing: LSIconButton(icon: Icons.report),
                onTap: () async => _viewLogs('Error'),
            ),
            LSCardTile(
                title: LSTitle(text: 'Fatal'),
                subtitle: LSSubtitle(text: 'View fatal logs'),
                trailing: LSIconButton(icon: Icons.new_releases),
                onTap: () async => _viewLogs('Fatal'),
            ),
        ],
        padBottom: true,
    );

    Future<void> _viewLogs(String type) async => Navigator.of(context).pushNamed(
        SettingsGeneralLogsView.ROUTE_NAME,
        arguments: SettingsGeneralLogsViewArguments(type: type),
    );
}

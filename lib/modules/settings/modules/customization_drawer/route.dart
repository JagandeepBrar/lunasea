import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationDrawerRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/drawer';

    @override
    State<SettingsCustomizationDrawerRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationDrawerRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Drawer');

    Widget get _body => LSListView(
        children: [
            SettingsCustomizationDrawerExpandAutomationTile(),
            SettingsCustomizationDrawerExpandClientsTile(),
            SettingsCustomizationDrawerExpandMonitoringTile(),
        ],
    );
}

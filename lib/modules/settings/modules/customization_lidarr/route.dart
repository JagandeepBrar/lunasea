import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationLidarrRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/lidarr';

    @override
    State<SettingsCustomizationLidarrRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationLidarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Lidarr',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => Navigator.of(context).pushNamed(SettingsModulesLidarrRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            SettingsCustomizationLidarrDefaultPageTile(),
        ],
    );
}

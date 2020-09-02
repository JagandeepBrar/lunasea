import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationRadarrRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/radarr';

    @override
    State<SettingsCustomizationRadarrRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationRadarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Radarr',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => Navigator.of(context).pushNamed(SettingsModulesRadarrRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            SettingsCustomizationRadarrDefaultPageTile(),
        ],
    );
}

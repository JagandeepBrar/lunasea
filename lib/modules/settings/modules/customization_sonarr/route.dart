import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationSonarrRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/sonarr';

    @override
    State<SettingsCustomizationSonarrRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationSonarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Sonarr',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => Navigator.of(context).pushNamed(SettingsModulesSonarrRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            SettingsCustomizationSonarrDefaultPageTile(),
        ],
    );
}

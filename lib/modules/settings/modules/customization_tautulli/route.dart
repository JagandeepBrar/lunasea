import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationTautulliRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/tautulli';

    @override
    State<SettingsCustomizationTautulliRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationTautulliRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Tautulli',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => Navigator.of(context).pushNamed(SettingsModulesTautulliRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            SettingsCustomizationTautulliDefaultPageTile(),
        ],
    );
}

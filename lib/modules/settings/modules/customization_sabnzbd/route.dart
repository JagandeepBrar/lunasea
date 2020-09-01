import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationSABnzbdRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/sabnzbd';

    @override
    State<SettingsCustomizationSABnzbdRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationSABnzbdRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'SABnzbd',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => Navigator.of(context).pushNamed(SettingsModulesSABnzbdRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            SettingsCustomizationSABnzbdDefaultPageTile(),
        ],
    );
}

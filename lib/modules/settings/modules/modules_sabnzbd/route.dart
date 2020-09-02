import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSABnzbdRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/sabnzbd';

    @override
    State<SettingsModulesSABnzbdRoute> createState() => _State();
}

class _State extends State<SettingsModulesSABnzbdRoute> {
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
                icon: Icons.brush,
                onPressed: () async => Navigator.of(context).pushNamed(SettingsCustomizationSABnzbdRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._mandatory,
                LSDivider(),
                SettingsModulesSABnzbdTestConnectionTile(),
                ..._advanced,
            ],
        ),
    );

    List<Widget> get _mandatory => [
        LSHeader(
            text: 'Mandatory',
            subtitle: 'Configuration that is required for functionality',
        ),
        SettingsModulesSABnzbdEnabledTile(),
        SettingsModulesSABnzbdHostTile(),
        SettingsModulesSABnzbdAPIKeyTile(),
    ];

    List<Widget> get _advanced => [
        LSHeader(
            text: 'Advanced',
            subtitle: 'Options for non-standard networking configurations',
        ),
        SettingsModulesSABnzbdCustomHeadersTile(),
        SettingsModulesSABnzbdStrictTLSTile(),
    ];
}

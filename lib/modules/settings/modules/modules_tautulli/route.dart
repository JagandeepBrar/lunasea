import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesTautulliRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/tautulli';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsModulesTautulliRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsModulesTautulliRoute> createState() => _State();
}

class _State extends State<SettingsModulesTautulliRoute> {
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
                icon: Icons.brush,
                onPressed: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationTautulliRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._mandatory,
                LSDivider(),
                SettingsModulesTautulliTestConnectionTile(),
                ..._advanced,
            ],
        ),
    );

    List<Widget> get _mandatory => [
        LSHeader(
            text: 'Mandatory',
            subtitle: 'Configuration that is required for functionality',
        ),
        SettingsModulesTautulliEnabledTile(),
        SettingsModulesTautulliHostTile(),
        SettingsModulesTautulliAPIKeyTile(),
    ];

    List<Widget> get _advanced => [
        LSHeader(
            text: 'Advanced',
            subtitle: 'Options for non-standard networking configurations',
        ),
        SettingsModulesTautulliCustomHeadersTile(),
        SettingsModulesTautulliStrictTLSTile(),
    ];
}

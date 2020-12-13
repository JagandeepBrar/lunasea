import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsConfigurationDrawerRouter extends LunaPageRouter {
    static const ROUTE_NAME = '/settings/configuration/drawer';

    Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        ROUTE_NAME,
    );

    String route(List parameters) => ROUTE_NAME;
    
    void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsCustomizationDrawerRoute()),
        transitionType: LunaRouter.transitionType,
    );
}

class _SettingsCustomizationDrawerRoute extends StatefulWidget {
    @override
    State<_SettingsCustomizationDrawerRoute> createState() => _State();
}

class _State extends State<_SettingsCustomizationDrawerRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Drawer',
    );

    Widget get _body => LSListView(
        children: [
            ..._folders,  
        ],
    );

    List<Widget> get _folders => [
        _useCategoriesTile,
        _expandAutomationTile,
        _expandClientsTile,
        _expandMonitoringTile,
    ];

    Widget get _useCategoriesTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Use Folders'),
            subtitle: LSSubtitle(text: 'Group Modules into Categories'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.data,
                onChanged: (value) => LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.put(value),
            ),
        ),
    );

    Widget get _expandAutomationTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION.key,
            LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.key,
        ]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Automation'),
            subtitle: LSSubtitle(text: 'Expand Automation Folder Initially'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION.data,
                onChanged: LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.data
                    ? (value) => LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION.put(value)
                    : null,
            ),
        ),
    );

    Widget get _expandClientsTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS.key,
            LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.key,
        ]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Clients'),
            subtitle: LSSubtitle(text: 'Expand Clients Folder Initially'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS.data,
                onChanged: LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.data
                    ? (value) => LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS.put(value)
                    : null,
                ),
        ),
    );

    Widget get _expandMonitoringTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING.key,
            LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.key,
        ]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Monitoring'),
            subtitle: LSSubtitle(text: 'Expand Monitoring Folder Initially'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING.data,
                onChanged: LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.data
                    ? (value) => LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING.put(value)
                    : null,
            ),
        ),
    );
}

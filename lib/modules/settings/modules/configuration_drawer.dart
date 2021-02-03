import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsConfigurationDrawerRouter extends LunaPageRouter {
    SettingsConfigurationDrawerRouter() : super('/settings/configuration/drawer');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationDrawerRoute());
}

class _SettingsConfigurationDrawerRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationDrawerRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationDrawerRoute> {
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
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.DRAWER_GROUP_MODULES.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Use Folders'),
            subtitle: LSSubtitle(text: 'Group Modules into Categories'),
            trailing: LunaSwitch(
                value: LunaDatabaseValue.DRAWER_GROUP_MODULES.data,
                onChanged: (value) => LunaDatabaseValue.DRAWER_GROUP_MODULES.put(value),
            ),
        ),
    );

    Widget get _expandAutomationTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaDatabaseValue.DRAWER_EXPAND_AUTOMATION.key,
            LunaDatabaseValue.DRAWER_GROUP_MODULES.key,
        ]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Automation'),
            subtitle: LSSubtitle(text: 'Expand Automation Folder Initially'),
            trailing: LunaSwitch(
                value: LunaDatabaseValue.DRAWER_EXPAND_AUTOMATION.data,
                onChanged: LunaDatabaseValue.DRAWER_GROUP_MODULES.data
                    ? (value) => LunaDatabaseValue.DRAWER_EXPAND_AUTOMATION.put(value)
                    : null,
            ),
        ),
    );

    Widget get _expandClientsTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaDatabaseValue.DRAWER_EXPAND_CLIENTS.key,
            LunaDatabaseValue.DRAWER_GROUP_MODULES.key,
        ]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Clients'),
            subtitle: LSSubtitle(text: 'Expand Clients Folder Initially'),
            trailing: LunaSwitch(
                value: LunaDatabaseValue.DRAWER_EXPAND_CLIENTS.data,
                onChanged: LunaDatabaseValue.DRAWER_GROUP_MODULES.data
                    ? (value) => LunaDatabaseValue.DRAWER_EXPAND_CLIENTS.put(value)
                    : null,
                ),
        ),
    );

    Widget get _expandMonitoringTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaDatabaseValue.DRAWER_EXPAND_MONITORING.key,
            LunaDatabaseValue.DRAWER_GROUP_MODULES.key,
        ]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Expand Monitoring'),
            subtitle: LSSubtitle(text: 'Expand Monitoring Folder Initially'),
            trailing: LunaSwitch(
                value: LunaDatabaseValue.DRAWER_EXPAND_MONITORING.data,
                onChanged: LunaDatabaseValue.DRAWER_GROUP_MODULES.data
                    ? (value) => LunaDatabaseValue.DRAWER_EXPAND_MONITORING.put(value)
                    : null,
            ),
        ),
    );
}

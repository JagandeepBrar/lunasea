import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesHome extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/home';
    
    @override
    State<SettingsModulesHome> createState() => _State();
}

class _State extends State<SettingsModulesHome> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Home');

    Widget get _body => LSListView(
        children: <Widget>[
            ..._customization,
            ..._calendarModules,
        ],
    );

    List<Widget> get _customization => [
        LSHeader(
            text: 'Customization',
            subtitle: 'Make the home screen fit your needs',
        ),
        SettingsModulesHomeDefaultPageTile(),
        SettingsModulesHomeCalendarStartingDateTile(),
        SettingsModulesHomeCalendarStartingSizeTile(),
    ];

    List<Widget> get _calendarModules => [
        LSHeader(
            text: 'Calendar Modules',
            subtitle: 'Choose which modules are active in the calendar',
        ),
        if(ModuleFlags.LIDARR) SettingsModulesCalendarEnableLidarrTile(),
        if(ModuleFlags.RADARR) SettingsModulesCalendarEnableRadarrTile(),
        if(ModuleFlags.SONARR) SettingsModulesCalendarEnableSonarrTile(),
    ];
}

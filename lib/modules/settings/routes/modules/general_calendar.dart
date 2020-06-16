import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesCalendar extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/calendar';
    
    @override
    State<SettingsModulesCalendar> createState() => _State();
}

class _State extends State<SettingsModulesCalendar> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Calendar');

    Widget get _body => LSListView(
        children: <Widget>[
            ..._calendar,
            ..._calendarModules,
        ],
    );

    List<Widget> get _calendar => [
        LSHeader(
            text: 'Customization',
            subtitle: 'Make the calendar fit your needs',
        ),
        SettingsModulesCalendarStartingDateTile(),
        SettingsModulesCalendarStartingSizeTile(),
        
    ];

    List<Widget> get _calendarModules => [
        LSHeader(
            text: 'Modules',
            subtitle: 'Choose which modules are active in the calendar',
        ),
        SettingsModulesCalendarEnableLidarrTile(),
        SettingsModulesCalendarEnableRadarrTile(),
        SettingsModulesCalendarEnableSonarrTile(),
    ];
}

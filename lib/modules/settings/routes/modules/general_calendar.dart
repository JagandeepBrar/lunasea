import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../../settings.dart';

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
        padBottom: true,
    );

    List<Widget> get _calendar => [
        LSHeader(text: 'Customization'),
        SettingsModulesCalendarStartingDateTile(),
        SettingsModulesCalendarStartingSizeTile(),
        
    ];

    List<Widget> get _calendarModules => [
        LSHeader(text: 'Modules'),
        SettingsModulesCalendarEnableLidarrTile(),
        SettingsModulesCalendarEnableRadarrTile(),
        SettingsModulesCalendarEnableSonarrTile(),
    ];
}

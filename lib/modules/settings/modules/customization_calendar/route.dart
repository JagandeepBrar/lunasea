import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationCalendarRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/calendar';

    @override
    State<SettingsCustomizationCalendarRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationCalendarRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Calendar');

    Widget get _body => LSListView(
        children: [
            SettingsCustomizationCalendarStartingDateTile(),
            SettingsCustomizationCalendarStartingSizeTile(),
            SettingsCustomizationCalendarStartingTypeTile(),
            LSDivider(),
            SettingsCustomizationCalendarEnableLidarrTile(),
            SettingsCustomizationCalendarEnableRadarrTile(),
            SettingsCustomizationCalendarEnableSonarrTile(),
        ],
    );
}

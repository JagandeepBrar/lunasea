import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationCalendarRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/calendar';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsCustomizationCalendarRoute()),
        transitionType: LunaRouter.transitionType,
    );

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

import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationAppearanceRouter {
    static const ROUTE_NAME = '/settings/customization/appearance';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsCustomizationAppearanceRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsCustomizationAppearanceRouter._();
}

class _SettingsCustomizationAppearanceRoute extends StatefulWidget {
    @override
    State<_SettingsCustomizationAppearanceRoute> createState() => _State();
}

class _State extends State<_SettingsCustomizationAppearanceRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        popUntil: '/settings',
        title: 'Appearance',
    );

    Widget get _body => LSListView(
        children: [
            ..._theme,
            ..._localization,
        ],
    );

    List<Widget> get _theme => [
        LSHeader(
            text: 'Theme',
            subtitle: 'Customize the theme of LunaSea',
        ),
        SettingsCustomizationAppearanceAMOLEDTile(),
        SettingsCustomizationAppearanceAMOLEDBorderTile(),
        SettingsCustomizationAppearanceBackgroundImageOpacityTile(),

    ];

    List<Widget> get _localization => [
        LSHeader(
            text: 'Localization',
            subtitle: 'Customizable options for localization',
        ),
        SettingsCustomizationAppearance24HourTimeTile(),
    ];
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationAppearanceRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/appearance';

    @override
    State<SettingsCustomizationAppearanceRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationAppearanceRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Appearance');

    Widget get _body => LSListView(
        children: [
            SettingsCustomizationAppearanceAMOLEDTile(),
            SettingsCustomizationAppearanceAMOLEDBorderTile(),
            SettingsCustomizationAppearance24HourTimeTile(),
        ],
    );
}

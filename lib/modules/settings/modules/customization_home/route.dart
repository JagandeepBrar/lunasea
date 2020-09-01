import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationHomeRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/home';

    @override
    State<SettingsCustomizationHomeRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationHomeRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Home');

    Widget get _body => LSListView(
        children: [
            SettingsCustomizationHomeDefaultPageTile(),
            SettingsCustomizationHomeBrandColoursTile(),
        ],
    );
}

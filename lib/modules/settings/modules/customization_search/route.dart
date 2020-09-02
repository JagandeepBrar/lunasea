import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationSearchRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/search';

    @override
    State<SettingsCustomizationSearchRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationSearchRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Search',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => Navigator.of(context).pushNamed(SettingsModulesSearchRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            SettingsCustomizationSearchHideAdultCategoriesTile(),
        ],
    );
}

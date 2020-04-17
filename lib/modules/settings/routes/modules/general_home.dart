import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../../settings.dart';

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
            ..._quickAccess,
            ..._calendar,
        ],
        padBottom: true,
    );

    List<Widget> get _quickAccess => [
        LSHeader(text: 'Quick Access'),
        LSGenericMessage(text: 'Coming Soon'),
    ];

    List<Widget> get _calendar => [
        LSHeader(text: 'Calendar'),
        SettingsModulesHomeStartingDateTile(),
        SettingsModulesHomeStartingSizeTile(),
    ];
}

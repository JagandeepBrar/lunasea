import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

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

    Widget get _body => LSGenericMessage(text: 'Coming Soon');
}

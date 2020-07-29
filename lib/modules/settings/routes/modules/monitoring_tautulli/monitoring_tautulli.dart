import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesTautulli extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/tautulli';
    
    @override
    State<SettingsModulesTautulli> createState() => _State();
}

class _State extends State<SettingsModulesTautulli> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Tautulli');

    Widget get _body => LSGenericMessage(text: "Coming Soon!");
}

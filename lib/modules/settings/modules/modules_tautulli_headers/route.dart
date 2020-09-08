import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesTautulliHeadersRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/tautulli/headers';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsModulesTautulliHeadersRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsModulesTautulliHeadersRoute> createState() => _State();
}

class _State extends State<SettingsModulesTautulliHeadersRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Custom Headers');

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, profile, _) => LSListView(
            children: _headers,
        ),
    );

    List<Widget> get _headers => [
        if((Database.currentProfileObject.tautulliHeaders ?? {}).isEmpty) _noHeaders,
        ..._list,
        LSDivider(),
        SettingsModulesTautulliHeadersAddHeaderTile(),
    ];

    Widget get _noHeaders => LSGenericMessage(text: 'No Custom Headers Added');

    List<Widget> get _list {
        Map<String, dynamic> headers = (Database.currentProfileObject.tautulliHeaders ?? {}).cast<String, dynamic>();
        List<SettingsModulesTautulliHeadersHeaderTile> list = [];
        headers.forEach((key, value) => list.add(SettingsModulesTautulliHeadersHeaderTile(
            headerKey: key.toString(),
            headerValue: value.toString(),
        )));
        list.sort((a,b) => a.headerKey.toLowerCase().compareTo(b.headerKey.toLowerCase()));
        return list;
    }
}

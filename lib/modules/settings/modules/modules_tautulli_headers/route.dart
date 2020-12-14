import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesTautulliHeadersRouter {
    static const ROUTE_NAME = '/settings/modules/tautulli/headers';

    static Future<void> navigateTo(BuildContext context, [List parameters]) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesTautulliHeadersRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesTautulliHeadersRouter._();
}

class _SettingsModulesTautulliHeadersRoute extends StatefulWidget {
    @override
    State<_SettingsModulesTautulliHeadersRoute> createState() => _State();
}

class _State extends State<_SettingsModulesTautulliHeadersRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Custom Headers',
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, profile, _) => LSListView(
            children: _headers,
        ),
    );

    List<Widget> get _headers => [
        if((Database.currentProfileObject.tautulliHeaders ?? {}).isEmpty) _noHeaders,
        ..._list,
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

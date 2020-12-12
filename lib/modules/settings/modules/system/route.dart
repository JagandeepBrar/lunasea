import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemRouter {
    static const ROUTE_NAME = '/settings/system';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsSystemRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsSystemRouter._();
}

class _SettingsSystemRoute extends StatefulWidget {
    @override
    State<_SettingsSystemRoute> createState() => _State();
}

class _State extends State<_SettingsSystemRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _body,
        );
    }

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'System',
    );

    Widget get _body => LSListView(
        children: <Widget>[
            SettingsSystemVersionTile(),
            LSDivider(),
            SettingsSystemEnableSentryTile(),
            SettingsSystemClearConfigurationTile(),
        ],
    );
}

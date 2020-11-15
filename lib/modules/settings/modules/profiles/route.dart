import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsProfilesRouter {
    static const ROUTE_NAME = '/settings/profiles';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsProfilesRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsProfilesRouter._();
}

class _SettingsProfilesRoute extends StatefulWidget {
    @override
    State<_SettingsProfilesRoute> createState() => _State();
}

class _State extends State<_SettingsProfilesRoute> with AutomaticKeepAliveClientMixin {
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            appBar: _appBar,
            body: _body,
        );
    }

    Widget get _appBar => LunaAppBar(
        context: context,
        popUntil: '/settings',
        title: 'Profiles',
    );

    Widget get _body => LSListView(
        children: [
            SettingsProfileEnabledTile(),
            SettingsProfileAddTile(),
            SettingsProfileRenameTile(),
            SettingsProfileDeleteTile(),
        ],
    );
}

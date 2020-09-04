import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/system';
    static String route() => ROUTE_NAME;
    
    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsSystemRoute()),
        transitionType: LunaRouter.transitionType,
    );
    
    SettingsSystemRoute({
        Key key,
    }): super(key: key);

    @override
    State<SettingsSystemRoute> createState() => _State();
}

class _State extends State<SettingsSystemRoute> with AutomaticKeepAliveClientMixin {
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

    Widget get _appBar => LSAppBar(title: 'System');

    Widget get _body => LSListView(
        children: <Widget>[
            SettingsSystemLicensesTile(),
            SettingsSystemVersionTile(),
            LSDivider(),
            SettingsSystemEnableSentryTile(),
            SettingsSystemClearImageCacheTile(),
            SettingsSystemClearConfigurationTile(),
        ],
    );
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrHealthCheckRouter extends LunaPageRouter {
    RadarrHealthCheckRouter() : super('/radarr/system/health');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrHealthCheckRoute());
}


class _RadarrHealthCheckRoute extends StatefulWidget {
    @override
    State<_RadarrHealthCheckRoute> createState() => _State();
}

class _State extends State<_RadarrHealthCheckRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: LunaMessage.goBack(context: context, text: 'Coming Soon'),
    );

    Widget get _appBar => LunaAppBar(title: 'Health Check', state: context.read<RadarrState>());
}

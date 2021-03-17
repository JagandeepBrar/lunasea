import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliSearchRouter extends TautulliPageRouter {
    TautulliSearchRouter() : super('/tautulli/search');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliSearchRoute());
}

class _TautulliSearchRoute extends StatefulWidget {
    @override
    State<_TautulliSearchRoute> createState() => _State();
}

class _State extends State<_TautulliSearchRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: TautulliSearchAppBar(),
        body: TautulliSearchSearchResults(),
    );
}
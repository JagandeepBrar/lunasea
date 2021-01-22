import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesDetailsRouter extends LunaPageRouter {
    RadarrMoviesDetailsRouter() : super('/radarr/movies/details');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrMoviesDetailsRoute());
}

class _RadarrMoviesDetailsRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrMoviesDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        context.read<RadarrState>().resetQualityProfiles();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
    );
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class _SonarrAddSeriesArguments {
    final String query;

    _SonarrAddSeriesArguments(this.query);
}

class SonarrAddSeriesRouter extends SonarrPageRouter {
    SonarrAddSeriesRouter() : super('/sonarr/addseries');

    @override
    Future<void> navigateTo(BuildContext context, { @required String query }) async => LunaRouter.router.navigateTo(
        context,
        route(),
        routeSettings: RouteSettings(arguments: _SonarrAddSeriesArguments(query)),
    );

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SonarrAddSeriesRoute());
}

class _SonarrAddSeriesRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrAddSeriesRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    _SonarrAddSeriesArguments _arguments;

    @override
    Widget build(BuildContext context) {
        _arguments = ModalRoute.of(context).settings.arguments;
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return SonarrSeriesAddAppBar(
            scrollController: scrollController,
            query: _arguments?.query,
            autofocus: (_arguments?.query ?? '').isEmpty,
        );
    }

    Widget _body() {
        return ChangeNotifierProvider(
            create: (context) => SonarrAddSeriesState(context, _arguments?.query ?? ''),
            builder: (context, _) => SonarrSeriesAddSearchResults(scrollController: scrollController),
        );
    }
}

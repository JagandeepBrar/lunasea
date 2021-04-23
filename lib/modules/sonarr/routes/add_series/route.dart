import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAddSeriesRouter extends SonarrPageRouter {
  SonarrAddSeriesRouter() : super('/sonarr/addseries');

  @override
  _Widget widget() => _Widget();

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required String query,
  }) async =>
      LunaRouter.router.navigateTo(
        context,
        route(),
        routeSettings: RouteSettings(arguments: _Arguments(query)),
      );

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Arguments {
  final String query;

  _Arguments(this.query);
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _Arguments _arguments;

  @override
  Widget build(BuildContext context) {
    _arguments = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
      create: (context) => SonarrAddSeriesState(
        context,
        _arguments?.query ?? '',
      ),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar(),
        body: SonarrSeriesAddSearchResults(scrollController: scrollController),
      ),
    );
  }

  Widget _appBar() {
    return SonarrSeriesAddAppBar(
      scrollController: scrollController,
      query: _arguments?.query,
      autofocus: (_arguments?.query ?? '').isEmpty,
    );
  }
}

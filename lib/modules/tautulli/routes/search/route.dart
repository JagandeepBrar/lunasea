import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliSearchRouter extends TautulliPageRouter {
  TautulliSearchRouter() : super('/tautulli/search');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        module: LunaModule.TAUTULLI,
        appBar: TautulliSearchAppBar(scrollController: scrollController)
            as PreferredSizeWidget?,
        body: TautulliSearchSearchResults(scrollController: scrollController),
      );
}

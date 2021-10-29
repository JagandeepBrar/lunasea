import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsRouter extends TautulliPageRouter {
  TautulliGraphsRouter() : super('/tautulli/graphs');

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

class _State extends State<_Widget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaPageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = LunaPageController(
        initialPage: TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.data);
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      pageController: _pageController,
      scrollControllers: TautulliGraphsNavigationBar.scrollControllers,
      title: 'Graphs',
      actions: const [
        TautulliGraphsTypeButton(),
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return TautulliGraphsNavigationBar(pageController: _pageController);
  }

  Widget _body() {
    return PageView(
      controller: _pageController,
      children: const [
        TautulliGraphsPlayByPeriodRoute(),
        TautulliGraphsStreamInformationRoute(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsRouter extends TautulliPageRouter {
    TautulliGraphsRouter() : super('/tautulli/graphs');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliGraphsRoute());
}

class _TautulliGraphsRoute extends StatefulWidget {
    @override
    State<_TautulliGraphsRoute> createState() => _State();
}

class _State extends State<_TautulliGraphsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.data);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        title: 'Graphs',
        actions: [
            TautulliGraphsTypeButton(),
        ],
    );

    Widget get _bottomNavigationBar => TautulliGraphsNavigationBar(pageController: _pageController);

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
    );

    List<Widget> get _tabs => [
        TautulliGraphsPlayByPeriodRoute(),
        TautulliGraphsStreamInformationRoute(),
    ];
}

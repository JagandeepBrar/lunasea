import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsRouter {
    static const String ROUTE_NAME = '/tautulli/more/graphs';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(FluroRouter router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliGraphsRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliGraphsRouter._();
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
        context: context, 
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

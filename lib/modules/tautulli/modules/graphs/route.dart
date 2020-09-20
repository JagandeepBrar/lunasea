import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsRouter {
    static const String ROUTE_NAME = '/tautulli/more/graphs';

    static Future<void> navigateTo(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        route(),
    );

    static String route({ String profile }) => [
        ROUTE_NAME,
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliGraphsRoute(
                profile: params['profile'] != null && params['profile'].length != 0
                    ? params['profile'][0]
                    : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliGraphsRoute(
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliGraphsRouter._();
}

class _TautulliGraphsRoute extends StatefulWidget {
    final String profile;

    _TautulliGraphsRoute({
        Key key,
        @required this.profile,
    }) : super(key: key);

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

    Widget get _appBar => LSAppBar(
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

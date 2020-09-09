import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/graphs/:profile';

    TautulliGraphsRoute({
        Key key,
    }) : super(key: key);

    @override
    State<TautulliGraphsRoute> createState() => _State();

    static String route({ String profile }) {
        if(profile == null) return '/tautulli/graphs/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
        return '/tautulli/graphs/$profile';
    }

    static void defineRoute(Router router) => router.define(
        TautulliGraphsRoute.ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => TautulliGraphsRoute()),
        transitionType: LunaRouter.transitionType,
    );
}

class _State extends State<TautulliGraphsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: Provider.of<TautulliLocalState>(context, listen: false).graphsNavigationIndex);
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
        onPageChanged: _onPageChanged,
    );

    List<Widget> get _tabs => [
        TautulliGraphsPlayByPeriodRoute(),
        TautulliGraphsStreamInformationRoute(),
    ];

    void _onPageChanged(int index) => Provider.of<TautulliLocalState>(context, listen: false).graphsNavigationIndex = index;
}
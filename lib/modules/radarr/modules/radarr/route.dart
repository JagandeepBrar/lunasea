import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrHomeRouter {
    static const ROUTE_NAME = '/radarr';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(FluroRouter router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _RadarrHomeRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    RadarrHomeRouter._();
}

class _RadarrHomeRoute extends StatefulWidget {
    @override
    State<_RadarrHomeRoute> createState() => _State();
}

class _State extends State<_RadarrHomeRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final ScrollController _catalogueScrollController = ScrollController();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: RadarrDatabaseValue.NAVIGATION_INDEX.data);
    }

    @override
    Widget build(BuildContext context) => WillPopScope(
        onWillPop: _onWillPop,
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [ LunaDatabaseValue.ENABLED_PROFILE.key ]),
            builder: (context, box, _) => Scaffold(
                key: _scaffoldKey,
                drawer: _drawer,
                appBar: _appBar,
                bottomNavigationBar: _bottomNavigationBar,
                body: _body,
            ),
        ),
    );

    Future<bool> _onWillPop() async {
        if(_scaffoldKey.currentState.isDrawerOpen) return true;
        _scaffoldKey.currentState.openDrawer();
        return false;
    }

    Widget get _drawer => LSDrawer(page: 'radarr');

    Widget get _bottomNavigationBar => RadarrNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        Container(),
        Container(),
        Container(),
        Container(),
        // RadarrSeriesRoute(scrollController: _catalogueScrollController),
        // RadarrUpcomingRoute(),
        // RadarrMissingRoute(),
        // RadarrHistoryRoute(),
    ];

    Widget get _body => Selector<RadarrState, bool>(
        selector: (_, state) => state.enabled,
        builder: (context, enabled, _) => PageView(
            controller: _pageController,
            children: enabled ? _tabs : List.generate(_tabs.length, (_) => LSNotEnabled('Radarr')),
        ),
    );

    Widget get _appBar => RadarrAppBar(
        context: context,
        profiles: Database.profilesBox.keys.fold([], (value, element) {
            if((Database.profilesBox.get(element) as ProfileHiveObject)?.radarrEnabled ?? false) value.add(element);
            return value;
        }),
        actions: Provider.of<RadarrState>(context).enabled
            ? [
                //RadarrAppBarAddSeriesAction(),
                //RadarrAppBarGlobalSettingsAction(),
            ]
            : null,
    );
}

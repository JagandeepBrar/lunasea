import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliHomeRouter {
    static const ROUTE_NAME = '/tautulli';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(FluroRouter router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliHomeRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliHomeRouter._();
}

class _TautulliHomeRoute extends StatefulWidget {
    @override
    State<_TautulliHomeRoute> createState() => _State();
}

class _State extends State<_TautulliHomeRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: TautulliDatabaseValue.NAVIGATION_INDEX.data);
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

    Widget get _drawer => LSDrawer(page: 'tautulli');

    Widget get _bottomNavigationBar => TautulliNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        TautulliActivityRoute(),
        TautulliUsersRoute(),
        TautulliHistoryRoute(),
        TautulliMoreRoute(),
    ];

    Widget get _body => Selector<TautulliState, bool>(
        selector: (_, state) => state.enabled,
        builder: (context, enabled, _) => PageView(
            controller: _pageController,
            children: enabled ? _tabs : List.generate(_tabs.length, (_) => LSNotEnabled('Tautulli')),
        ),
    );

    Widget get _appBar => LunaAppBar.dropdown(
        title: 'Tautulli',
        profiles: Database.profilesBox.keys.fold([], (value, element) {
            if((Database.profilesBox.get(element) as ProfileHiveObject)?.tautulliEnabled ?? false) value.add(element);
            return value;
        }),
        actions: context.read<TautulliState>().enabled ? [TautulliGlobalSettings()] : null,
    );
}

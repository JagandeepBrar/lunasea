import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliHomeRouter {
    static const ROUTE_NAME = '/tautulli';

    static Future<void> navigateTo(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        route(),
    );

    static String route({ String profile }) => [
        ROUTE_NAME,
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        /// With profile defined
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliHomeRoute(
                profile: params['profile'] != null && params['profile'].length != 0
                    ? params['profile'][0]
                    : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        /// Without profile defined
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliHomeRoute(
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliHomeRouter._();
}

class _TautulliHomeRoute extends StatefulWidget {
    final String profile;

    _TautulliHomeRoute({
        Key key,
        @required this.profile,
    }) : super(key: key);

    @override
    State<_TautulliHomeRoute> createState() => _State();
}

class _State extends State<_TautulliHomeRoute> {
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: TautulliDatabaseValue.NAVIGATION_INDEX.data);
    }

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [ LunaSeaDatabaseValue.ENABLED_PROFILE.key ]),
        builder: (context, box, _) => Scaffold(
            key: Provider.of<TautulliState>(context, listen: false).rootScaffoldKey,
            drawer: _drawer,
            appBar: _appBar,
            bottomNavigationBar: _bottomNavigationBar,
            body: _body,
        ),
    );

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

    Widget get _appBar => LSAppBarDropdown(
        context: context,
        title: 'Tautulli',
        profiles: Database.profilesBox.keys.fold([], (value, element) {
            if((Database.profilesBox.get(element) as ProfileHiveObject)?.tautulliEnabled ?? false) value.add(element);
            return value;
        }),
        actions: Provider.of<TautulliState>(context).enabled ? [TautulliGlobalSettings()] : null,
    );
}

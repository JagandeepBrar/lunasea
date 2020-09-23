import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrHomeRouter {
    static const ROUTE_NAME = '/sonarr';

    static Future<void> navigateTo(BuildContext context) async => SonarrRouter.router.navigateTo(
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
            handler: Handler(handlerFunc: (context, params) => _SonarrHomeRoute(
                profile: params['profile'] != null && params['profile'].length != 0
                    ? params['profile'][0]
                    : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        /// Without profile defined
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrHomeRoute(
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    SonarrHomeRouter._();
}

class _SonarrHomeRoute extends StatefulWidget {
    final String profile;

    _SonarrHomeRoute({
        Key key,
        @required this.profile,
    }) : super(key: key);

    @override
    State<_SonarrHomeRoute> createState() => _State();
}

class _State extends State<_SonarrHomeRoute> {
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: SonarrDatabaseValue.NAVIGATION_INDEX.data);
    }

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [ LunaSeaDatabaseValue.ENABLED_PROFILE.key ]),
        builder: (context, box, _) => Scaffold(
            key: Provider.of<SonarrState>(context, listen: false).rootScaffoldKey,
            drawer: _drawer,
            appBar: _appBar,
            bottomNavigationBar: _bottomNavigationBar,
            body: _body,
        ),
    );

    Widget get _drawer => LSDrawer(page: 'sonarr');

    Widget get _bottomNavigationBar => SonarrNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        SonarrSeriesRoute(),
        Container(),
        Container(),
        Container(),
    ];

    Widget get _body => Selector<SonarrState, bool>(
        selector: (_, state) => state.enabled,
        builder: (context, enabled, _) => PageView(
            controller: _pageController,
            children: enabled ? _tabs : List.generate(_tabs.length, (_) => LSNotEnabled('Sonarr')),
        ),
    );

    Widget get _appBar => LSAppBarDropdown(
        context: context,
        title: 'Sonarr',
        profiles: Database.profilesBox.keys.fold([], (value, element) {
            if((Database.profilesBox.get(element) as ProfileHiveObject)?.sonarrEnabled ?? false) value.add(element);
            return value;
        }),
        actions: Provider.of<SonarrState>(context).enabled ? [SonarrGlobalSettings()] : null,
    );
}

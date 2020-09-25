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

    static String route() => ROUTE_NAME;

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrHomeRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    SonarrHomeRouter._();
}

class _SonarrHomeRoute extends StatefulWidget {
    @override
    State<_SonarrHomeRoute> createState() => _State();
}

class _State extends State<_SonarrHomeRoute> {
    final ScrollController _catalogueScrollController = ScrollController();
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
        SonarrSeriesRoute(scrollController: _catalogueScrollController),
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

    Widget get _appBar => SonarrAppBar(
        context: context,
        profiles: Database.profilesBox.keys.fold([], (value, element) {
            if((Database.profilesBox.get(element) as ProfileHiveObject)?.sonarrEnabled ?? false) value.add(element);
            return value;
        }),
        scrollController: _catalogueScrollController,
        actions: Provider.of<SonarrState>(context).enabled
            ? [
                SonarrAppBarAddSeriesAction(),
                SonarrAppBarGlobalSettingsAction(),
            ]
            : null,
    );
}

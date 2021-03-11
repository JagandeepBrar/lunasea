import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrHomeRouter extends LunaPageRouter {
    SonarrHomeRouter() : super('/sonarr');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SonarrHomeRoute());
}

class _SonarrHomeRoute extends StatefulWidget {
    @override
    State<_SonarrHomeRoute> createState() => _State();
}

class _State extends State<_SonarrHomeRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final ScrollController _catalogueScrollController = ScrollController();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: SonarrDatabaseValue.NAVIGATION_INDEX.data);
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

    Widget get _drawer => LunaDrawer(page: LunaModule.SONARR.key);

    Widget get _bottomNavigationBar => SonarrNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        SonarrSeriesRoute(scrollController: _catalogueScrollController),
        SonarrUpcomingRoute(),
        SonarrMissingRoute(),
        SonarrHistoryRoute(),
    ];

    Widget get _body => Selector<SonarrState, bool>(
        selector: (_, state) => state.enabled,
        builder: (context, enabled, _) => PageView(
            controller: _pageController,
            children: enabled ? _tabs : List.generate(_tabs.length, (_) => LSNotEnabled('Sonarr')),
        ),
    );

    Widget get _appBar => LunaAppBar.dropdown(
        title: 'Sonarr',
        profiles: Database.profilesBox.keys.fold([], (value, element) {
            if(Database.profilesBox.get(element)?.sonarrEnabled ?? false) value.add(element);
            return value;
        }),
        actions: Provider.of<SonarrState>(context).enabled
            ? [
                SonarrAppBarAddSeriesAction(),
                SonarrAppBarGlobalSettingsAction(),
            ]
            : null,
    );
}

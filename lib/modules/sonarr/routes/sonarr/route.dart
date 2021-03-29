import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrHomeRouter extends SonarrPageRouter {
    SonarrHomeRouter() : super('/sonarr');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SonarrHomeRoute(), homeRoute: true);
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
    Widget build(BuildContext context) {
        return LunaWillPopScope(
            scaffoldKey: _scaffoldKey,
            child: ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [ LunaDatabaseValue.ENABLED_PROFILE.key ]),
                builder: (context, box, _) => Scaffold(
                    key: _scaffoldKey,
                    drawer: _drawer(),
                    appBar: _appBar(),
                    bottomNavigationBar: _bottomNavigationBar(),
                    body: _body(),
                ),
            ),
        );
    }

    Widget _drawer() => LunaDrawer(page: LunaModule.SONARR.key);

    Widget _bottomNavigationBar() {
        if(context.read<SonarrState>().enabled) return SonarrNavigationBar(pageController: _pageController);
        return null;
    }

    Widget _appBar() {
        List<String> profiles = Database.profilesBox.keys.fold([], (value, element) {
            if(Database.profilesBox.get(element)?.sonarrEnabled ?? false) value.add(element);
            return value;
        });
        List<Widget> actions;
        if(context.watch<SonarrState>().enabled) actions = [
            SonarrAppBarAddSeriesAction(),
            SonarrAppBarGlobalSettingsAction(),
        ];
        return LunaAppBar.dropdown(
            title: LunaModule.SONARR.name,
            useDrawer: true,
            profiles: profiles,
            actions: actions,
            pageController: _pageController,
            scrollControllers: SonarrNavigationBar.scrollControllers,
        );
    }

    Widget _body() {
        return Selector<SonarrState, bool>(
            selector: (_, state) => state.enabled,
            builder: (context, enabled, _) {
                if(!enabled) return LunaMessage.moduleNotEnabled(context: context, module: 'Sonarr');
                return PageView(
                    controller: _pageController,
                    children: [
                        SonarrSeriesRoute(scrollController: _catalogueScrollController),
                        SonarrUpcomingRoute(),
                        SonarrMissingRoute(),
                        SonarrHistoryRoute(),
                    ],
                );
            }
        );
    }
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrHomeRouter extends LunaPageRouter {
    RadarrHomeRouter() : super('/radarr');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrHomeRoute());
}

class _RadarrHomeRoute extends StatefulWidget {
    @override
    State<_RadarrHomeRoute> createState() => _State();
}

class _State extends State<_RadarrHomeRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    LunaPageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = LunaPageController(initialPage: RadarrDatabaseValue.NAVIGATION_INDEX.data);
    }

    @override
    Widget build(BuildContext context) => WillPopScope(
        onWillPop: _onWillPop,
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [ LunaDatabaseValue.ENABLED_PROFILE.key ]),
            builder: (context, box, _) => Scaffold(
                key: _scaffoldKey,
                drawer: _drawer,
                appBar: _appBar(),
                bottomNavigationBar: _bottomNavigationBar(),
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

    Widget _bottomNavigationBar() {
        if(context.read<RadarrState>().enabled) return RadarrNavigationBar(pageController: _pageController);
        return null;
    }

    Widget _appBar() {
        List<String> profiles = Database.profilesBox.keys.fold([], (value, element) {
            if((Database.profilesBox.get(element) as ProfileHiveObject)?.radarrEnabled ?? false) value.add(element);
            return value;
        });
        List<Widget> actions;
        if(context.watch<RadarrState>().enabled) actions = [
            RadarrAppBarAddMoviesAction(),
            RadarrAppBarGlobalSettingsAction(),
        ];
        return LunaAppBar.dropdown(
            title: 'Radarr',
            profiles: profiles,
            actions: actions,
            pageController: _pageController,
            scrollControllers: RadarrNavigationBar.scrollControllers,
        );
    }

    List<Widget> get _tabs => [
        RadarrCatalogueRoute(scrollController: RadarrNavigationBar.scrollControllers[0]),
        RadarrUpcomingRoute(scrollController: RadarrNavigationBar.scrollControllers[1]),
        RadarrMissingRoute(scrollController: RadarrNavigationBar.scrollControllers[2]),
        RadarrMoreRoute(scrollController: RadarrNavigationBar.scrollControllers[3]),
    ];

    Widget get _body => Selector<RadarrState, bool>(
        selector: (_, state) => state.enabled,
        builder: (context, enabled, _) {
            if(!enabled) return LunaMessage.moduleNotEnabled(context: context, module: 'Radarr');
            return PageView(
                controller: _pageController,
                children: enabled ? _tabs : List.generate(_tabs.length, (_) => LSNotEnabled('Radarr')),
            );
        }
    );
}

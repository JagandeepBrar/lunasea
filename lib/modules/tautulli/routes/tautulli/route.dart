import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliHomeRouter extends TautulliPageRouter {
    TautulliHomeRouter() : super('/tautulli');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliHomeRoute(), homeRoute: true);
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
    Widget build(BuildContext context) {
        return LunaScaffold(
            scaffoldKey: _scaffoldKey,
            drawer: _drawer(),
            appBar: _appBar(),
            bottomNavigationBar: _bottomNavigationBar(),
            body: _body(),
        );
    }

    Widget _drawer() => LunaDrawer(page: LunaModule.TAUTULLI.key);

    Widget _bottomNavigationBar() {
        if(context.read<TautulliState>().enabled) return TautulliNavigationBar(pageController: _pageController);
        return null;
    }

    Widget _appBar() {
        List<String> profiles = Database.profilesBox.keys.fold([], (value, element) {
            if(Database.profilesBox.get(element)?.tautulliEnabled ?? false) value.add(element);
            return value;
        });
        List<Widget> actions;
        if(context.watch<TautulliState>().enabled) actions = [
            TautulliAppBarGlobalSettingsAction(),
        ];
        return LunaAppBar.dropdown(
            title: LunaModule.TAUTULLI.name,
            useDrawer: true,
            profiles: profiles,
            actions: actions,
            pageController: _pageController,
            scrollControllers: TautulliNavigationBar.scrollControllers,
        );
    }

    Widget _body() {
        return Selector<TautulliState, bool>(
            selector: (_, state) => state.enabled,
            builder: (context, enabled, _) {
                if(!enabled) return LunaMessage.moduleNotEnabled(context: context, module: 'Tautulli');
                return PageView(
                    controller: _pageController,
                    children: [
                        TautulliActivityRoute(),
                        TautulliUsersRoute(),
                        TautulliHistoryRoute(),
                        TautulliMoreRoute(),
                    ],
                );
            },
        );
    }
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';

class DashboardHomeRouter extends DashboardPageRouter {
    DashboardHomeRouter() : super('/');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _DashboardHomeRoute());
}

class _DashboardHomeRoute extends StatefulWidget {    
    @override
    State<_DashboardHomeRoute> createState() => _State();
}

class _State extends State<_DashboardHomeRoute> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    LunaPageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = LunaPageController(initialPage: DashboardDatabaseValue.NAVIGATION_INDEX.data);
    }

    @override
    Widget build(BuildContext context) {
        return LunaWillPopScope(
            scaffoldKey: _scaffoldKey,
            child: Scaffold(
                key: _scaffoldKey,
                body: _body(),
                drawer: _drawer(),
                appBar: _appBar(),
                bottomNavigationBar: _bottomNavigationBar(),
            ),
        );
    }

    Widget _drawer() => LunaDrawer(page: LunaModule.DASHBOARD.key);

    Widget _bottomNavigationBar() => DashboardNavigationBar(pageController: _pageController);

    Widget _appBar() {
        return LunaAppBar(
            title: 'LunaSea',
            useDrawer: true,
            scrollControllers: DashboardNavigationBar.scrollControllers,
            pageController: _pageController,
            actions: [DashboardAppBarSwitchViewAction()],
        );
    }

    Widget _body() {
        return LunaDatabaseValue.ENABLED_PROFILE.listen(
            builder: (context, _, __) => PageView(
                controller: _pageController,
                children: _tabs,
            ),
        );
    }

    List<Widget> get _tabs => [
        DashboardModulesRoute(),
        DashboardCalendarRoute(),
    ];
}

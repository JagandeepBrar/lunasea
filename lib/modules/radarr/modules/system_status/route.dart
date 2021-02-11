import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrSystemStatusRouter extends LunaPageRouter {
    RadarrSystemStatusRouter() : super('/radarr/system/status');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrSystemStatusRoute());
}

class _RadarrSystemStatusRoute extends StatefulWidget {
    @override
    State<_RadarrSystemStatusRoute> createState() => _State();
}

class _State extends State<_RadarrSystemStatusRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    LunaPageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = LunaPageController(initialPage: RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS.data);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(),
        bottomNavigationBar: _bottomNavigationBar(),
        body: _body(),
    );

    Widget _appBar() {
        return LunaAppBar(
            title: 'System Status',
            pageController: _pageController,
            scrollControllers: RadarrSystemStatusNavigationBar.scrollControllers,
        );
    }

    Widget _bottomNavigationBar() {
        return RadarrSystemStatusNavigationBar(pageController: _pageController);
    }

    Widget _body() {
        return PageView(
            controller: _pageController,
            children: [
                RadarrSystemStatusAboutPage(scrollController: RadarrSystemStatusNavigationBar.scrollControllers[0]),
                RadarrSystemStatusDiskSpacePage(scrollController: RadarrSystemStatusNavigationBar.scrollControllers[1]),
            ],
        );
    }
}

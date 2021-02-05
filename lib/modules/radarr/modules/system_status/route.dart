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
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS.data);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(context: context, title: 'System Status');

    Widget get _bottomNavigationBar => RadarrSystemStatusNavigationBar(pageController: _pageController);

    Widget get _body => PageView(
        controller: _pageController,
        children: [
            RadarrSystemStatusAboutPage(),
            RadarrSystemStatusDiskSpacePage(),
        ],
    );
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesAddRouter extends LunaPageRouter {
    RadarrMoviesAddRouter() : super('/radarr/movies/add');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrMoviesAddRoute());
}

class _RadarrMoviesAddRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrMoviesAddRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.data);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: _bottomNavigationBar,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Add Movie',
    );

    Widget get _bottomNavigationBar => RadarrMoviesAddNavigationBar(pageController: _pageController);

    Widget get _body => PageView(
        controller: _pageController,
        children: [
            RadarrMoviesAddSearchPage(),
            RadarrMoviesAddDiscoverPage(),
        ],
    );
}

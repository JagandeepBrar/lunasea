import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieRouter extends LunaPageRouter {
    RadarrAddMovieRouter() : super('/radarr/addmovie');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrAddMovieRoute());
}

class _RadarrAddMovieRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrAddMovieRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    LunaPageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = LunaPageController(initialPage: RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.data);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            bottomNavigationBar: _bottomNavigationBar(),
            body: _body(),
        );
    }

    Widget _bottomNavigationBar() => RadarrAddMovieNavigationBar(pageController: _pageController);

    Widget _appBar() {
        return LunaAppBar(
            title: 'Add Movie',
            pageController: _pageController,
            scrollControllers: RadarrAddMovieNavigationBar.scrollControllers,
        );
    }

    Widget _body() {
        return ChangeNotifierProvider(
            create: (context) => RadarrAddMovieState(context),
            builder: (context, _) => PageView(
                controller: _pageController,
                children: [
                    RadarrAddMovieSearchPage(),
                    RadarrAddMovieDiscoverPage(),
                ],
            ),
        );
    }
}

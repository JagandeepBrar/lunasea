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
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.data);
    }

    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
            create: (context) => RadarrAddMovieState(context),
            builder: (context, _) => Scaffold(
                key: _scaffoldKey,
                appBar: _appBar(context),
                bottomNavigationBar: _bottomNavigationBar(context),
                body: _body(context),
            ),
        );
    }

    Widget _bottomNavigationBar(BuildContext context) {
        return RadarrAddMovieNavigationBar(pageController: _pageController);
    }

    Widget _appBar(BuildContext context) {
        return LunaAppBar(
            title: 'Add Movie',
            pageController: _pageController,
            scrollControllers: RadarrAddMovieNavigationBar.scrollControllers,
        );
    }

    Widget _body(BuildContext context) {
        return PageView(
            controller: _pageController,
            children: [
                RadarrAddMovieSearchPage(scrollController: RadarrAddMovieNavigationBar.scrollControllers[0]),
                RadarrAddMovieDiscoverPage(scrollController: RadarrAddMovieNavigationBar.scrollControllers[1]),
            ],
        );
    }
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class _RadarrAddMovieArguments {
    final String query;

    _RadarrAddMovieArguments(this.query);
}

class RadarrAddMovieRouter extends RadarrPageRouter {
    RadarrAddMovieRouter() : super('/radarr/addmovie');

    @override
    Future<void> navigateTo(BuildContext context, { @required String query }) async => LunaRouter.router.navigateTo(
        context,
        route(),
        routeSettings: RouteSettings(arguments: _RadarrAddMovieArguments(query)),
    );

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrAddMovieRoute());
}

class _RadarrAddMovieRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrAddMovieRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    _RadarrAddMovieArguments _arguments;
    LunaPageController _pageController;

    @override
    Widget build(BuildContext context) {
        _arguments = ModalRoute.of(context).settings.arguments;
        _pageController = LunaPageController(initialPage: (_arguments?.query ?? '').isNotEmpty ? 0 : RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.data);
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
            title: 'radarr.AddMovie'.tr(),
            pageController: _pageController,
            scrollControllers: RadarrAddMovieNavigationBar.scrollControllers,
        );
    }

    Widget _body() {
        return ChangeNotifierProvider(
            create: (context) => RadarrAddMovieState(context, _arguments?.query ?? ''),
            builder: (context, _) => PageView(
                controller: _pageController,
                children: [
                    RadarrAddMovieSearchPage(autofocusSearchBar: (_arguments?.query ?? '').isEmpty && _pageController.initialPage == 0),
                    RadarrAddMovieDiscoverPage(),
                ],
            ),
        );
    }
}

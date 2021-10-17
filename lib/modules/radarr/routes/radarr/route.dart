import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrHomeRouter extends RadarrPageRouter {
  RadarrHomeRouter() : super('/radarr');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(
        router,
        homeRoute: true,
      );
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaPageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = LunaPageController(
      initialPage: RadarrDatabaseValue.NAVIGATION_INDEX.data,
    );
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

  Widget _drawer() {
    return LunaDrawer(page: LunaModule.RADARR.key);
  }

  Widget _bottomNavigationBar() {
    if (context.read<RadarrState>().enabled) {
      return RadarrNavigationBar(pageController: _pageController);
    }
    return null;
  }

  Widget _appBar() {
    List<String> profiles = Database.profilesBox.keys.fold(
      [],
      (value, element) {
        if (Database.profilesBox.get(element)?.radarrEnabled ?? false) {
          value.add(element);
        }
        return value;
      },
    );
    List<Widget> actions;
    if (context.watch<RadarrState>().enabled) {
      actions = [
        RadarrAppBarAddMoviesAction(),
        RadarrAppBarGlobalSettingsAction(),
      ];
    }
    return LunaAppBar.dropdown(
      title: LunaModule.RADARR.name,
      useDrawer: true,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: RadarrNavigationBar.scrollControllers,
    );
  }

  Widget _body() {
    return Selector<RadarrState, bool>(
      selector: (_, state) => state.enabled,
      builder: (context, enabled, _) {
        if (!enabled) {
          return LunaMessage.moduleNotEnabled(
            context: context,
            module: 'Radarr',
          );
        }
        return PageView(
          controller: _pageController,
          children: [
            RadarrCatalogueRoute(),
            RadarrUpcomingRoute(),
            RadarrMissingRoute(),
            RadarrMoreRoute(),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrHomeRouter extends ReadarrPageRouter {
  ReadarrHomeRouter() : super('/readarr');

  @override
  _Widget widget() => _Widget();

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
  LunaPageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = LunaPageController(
      initialPage: ReadarrDatabaseValue.NAVIGATION_INDEX.data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.READARR,
      drawer: _drawer(),
      appBar: _appBar() as PreferredSizeWidget?,
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(),
    );
  }

  Widget _drawer() {
    return LunaDrawer(page: LunaModule.READARR.key);
  }

  Widget? _bottomNavigationBar() {
    if (context.read<ReadarrState>().enabled) {
      return ReadarrNavigationBar(pageController: _pageController);
    }
    return null;
  }

  Widget _appBar() {
    List<String> profiles = Database.profiles.box.keys.fold(
      [],
      (value, element) {
        if (Database.profiles.box.get(element)?.readarrEnabled ?? false) {
          value.add(element);
        }
        return value;
      },
    );
    List<Widget>? actions;
    if (context.watch<ReadarrState>().enabled) {
      actions = [
        const ReadarrAppBarAddSeriesAction(),
        const ReadarrAppBarGlobalSettingsAction(),
      ];
    }
    return LunaAppBar.dropdown(
      title: LunaModule.READARR.name,
      useDrawer: true,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: ReadarrNavigationBar.scrollControllers,
    );
  }

  Widget _body() {
    return Selector<ReadarrState, bool?>(
      selector: (_, state) => state.enabled,
      builder: (context, enabled, _) {
        if (!enabled!) {
          return LunaMessage.moduleNotEnabled(
            context: context,
            module: 'Readarr',
          );
        }
        return LunaPageView(
          controller: _pageController,
          children: const [
            ReadarrCatalogueRoute(),
            ReadarrUpcomingRoute(),
            ReadarrMissingRoute(),
            ReadarrMoreRoute(),
          ],
        );
      },
    );
  }
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrHomeRouter extends OverseerrPageRouter {
  OverseerrHomeRouter() : super('/overseerr');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router, homeRoute: true);
  }
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
      initialPage: OverseerrDatabaseValue.NAVIGATION_INDEX.data,
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
    return LunaDrawer(page: LunaModule.OVERSEERR.key);
  }

  Widget _bottomNavigationBar() {
    if (context.read<OverseerrState>().enabled) {
      return OverseerrNavigationBar(pageController: _pageController);
    }
    return null;
  }

  Widget _appBar() {
    List<String> profiles = Database.profilesBox.keys.fold(
      [],
      (value, element) {
        if (Database.profilesBox.get(element)?.overseerrEnabled ?? false) {
          value.add(element);
        }
        return value;
      },
    );
    List<Widget> actions;
    if (context.watch<OverseerrState>().enabled) actions = [];
    return LunaAppBar.dropdown(
      title: LunaModule.OVERSEERR.name,
      useDrawer: true,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: OverseerrNavigationBar.scrollControllers,
    );
  }

  Widget _body() {
    return Selector<OverseerrState, bool>(
      selector: (_, state) => state.enabled,
      builder: (context, enabled, _) {
        if (!enabled) {
          return LunaMessage.moduleNotEnabled(
            context: context,
            module: 'Overseerr',
          );
        }
        return PageView(
          controller: _pageController,
          children: [
            LunaMessage(
              text: 'Coming Soon',
              buttonText: 'Go to Dashboard',
              onTap: LunaModule.DASHBOARD.launch,
            ),
            LunaMessage(
              text: 'Coming Soon',
              buttonText: 'Go to Dashboard',
              onTap: LunaModule.DASHBOARD.launch,
            ),
          ],
        );
      },
    );
  }
}

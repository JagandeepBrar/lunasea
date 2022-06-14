import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliHomeRouter extends TautulliPageRouter {
  TautulliHomeRouter() : super('/tautulli');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router, homeRoute: true);
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: TautulliDatabase.NAVIGATION_INDEX.read());
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.TAUTULLI,
      drawer: _drawer(),
      appBar: _appBar() as PreferredSizeWidget?,
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(),
    );
  }

  Widget _drawer() => LunaDrawer(page: LunaModule.TAUTULLI.key);

  Widget? _bottomNavigationBar() {
    if (context.read<TautulliState>().enabled!)
      return TautulliNavigationBar(pageController: _pageController);
    return null;
  }

  Widget _appBar() {
    List<String> profiles = LunaBox.profiles.keys.fold([], (value, element) {
      if (LunaBox.profiles.read(element)?.tautulliEnabled ?? false)
        value.add(element);
      return value;
    });
    List<Widget>? actions;
    if (context.watch<TautulliState>().enabled!)
      actions = [
        const TautulliAppBarGlobalSettingsAction(),
      ];
    return LunaAppBar.dropdown(
      title: LunaModule.TAUTULLI.title,
      useDrawer: true,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: TautulliNavigationBar.scrollControllers,
    );
  }

  Widget _body() {
    return Selector<TautulliState, bool?>(
      selector: (_, state) => state.enabled,
      builder: (context, enabled, _) {
        if (!enabled!)
          return LunaMessage.moduleNotEnabled(
              context: context, module: 'Tautulli');
        return LunaPageView(
          controller: _pageController,
          children: const [
            TautulliActivityRoute(),
            TautulliUsersRoute(),
            TautulliHistoryRoute(),
            TautulliMoreRoute(),
          ],
        );
      },
    );
  }
}

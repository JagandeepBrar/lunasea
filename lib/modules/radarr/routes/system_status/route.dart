import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrSystemStatusRouter extends RadarrPageRouter {
  RadarrSystemStatusRouter() : super('/radarr/system/status');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
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
      initialPage: RadarrDatabase.NAVIGATION_INDEX_SYSTEM_STATUS.read(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      bottomNavigationBar:
          context.watch<RadarrState>().enabled ? _bottomNavigationBar() : null,
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
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
    return ChangeNotifierProvider(
      create: (context) => RadarrSystemStatusState(context),
      builder: (context, _) => LunaPageView(
        controller: _pageController,
        children: [
          RadarrSystemStatusAboutPage(
            scrollController:
                RadarrSystemStatusNavigationBar.scrollControllers[0],
          ),
          RadarrSystemStatusHealthCheckPage(
            scrollController:
                RadarrSystemStatusNavigationBar.scrollControllers[1],
          ),
          RadarrSystemStatusDiskSpacePage(
            scrollController:
                RadarrSystemStatusNavigationBar.scrollControllers[2],
          ),
        ],
      ),
    );
  }
}

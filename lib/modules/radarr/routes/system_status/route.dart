import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class SystemStatusRoute extends StatefulWidget {
  const SystemStatusRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SystemStatusRoute> createState() => _State();
}

class _State extends State<SystemStatusRoute> {
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

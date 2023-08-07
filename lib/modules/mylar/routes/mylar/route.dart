import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarRoute extends StatefulWidget {
  const MylarRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<MylarRoute> createState() => _State();
}

class _State extends State<MylarRoute> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaPageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = LunaPageController(
      initialPage: MylarDatabase.NAVIGATION_INDEX.read(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.SONARR,
      drawer: _drawer(),
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(),
    );
  }

  Widget _drawer() {
    return LunaDrawer(page: LunaModule.SONARR.key);
  }

  Widget? _bottomNavigationBar() {
    if (context.read<MylarState>().enabled) {
      return MylarNavigationBar(pageController: _pageController);
    }
    return null;
  }

  PreferredSizeWidget _appBar() {
    List<String> profiles = LunaBox.profiles.keys.fold(
      [],
      (value, element) {
        if (LunaBox.profiles.read(element)?.mylarEnabled ?? false) {
          value.add(element);
        }
        return value;
      },
    );
    List<Widget>? actions;
    if (context.watch<MylarState>().enabled) {
      actions = [
        const MylarAppBarAddSeriesAction(),
        const MylarAppBarGlobalSettingsAction(),
      ];
    }
    return LunaAppBar.dropdown(
      title: LunaModule.SONARR.title,
      useDrawer: true,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: MylarNavigationBar.scrollControllers,
    );
  }

  Widget _body() {
    return Selector<MylarState, bool?>(
      selector: (_, state) => state.enabled,
      builder: (context, enabled, _) {
        if (!enabled!) {
          return LunaMessage.moduleNotEnabled(
            context: context,
            module: 'Mylar',
          );
        }
        return LunaPageView(
          controller: _pageController,
          children: const [
            MylarCatalogueRoute(),
            MylarUpcomingRoute(),
            MylarMissingRoute(),
            MylarMoreRoute(),
          ],
        );
      },
    );
  }
}

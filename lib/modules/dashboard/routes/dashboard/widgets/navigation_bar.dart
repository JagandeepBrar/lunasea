import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class DashboardNavigationBar extends StatelessWidget {
  static List<ScrollController> scrollControllers = List.generate(
    icons.length,
    (_) => ScrollController(),
  );
  final PageController pageController;

  static List<String> get titles => [
        'dashboard.Modules'.tr(),
        'dashboard.Calendar'.tr(),
      ];

  static const List<IconData> icons = [
    LunaIcons.modules,
    LunaIcons.calendar,
  ];

  const DashboardNavigationBar({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomNavigationBar(
      pageController: pageController,
      scrollControllers: scrollControllers,
      icons: icons,
      titles: titles,
    );
  }
}

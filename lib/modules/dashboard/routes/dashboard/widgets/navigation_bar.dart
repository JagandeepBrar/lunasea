import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class HomeNavigationBar extends StatelessWidget {
  final PageController? pageController;

  static List<ScrollController> scrollControllers = List.generate(
    icons.length,
    (_) => ScrollController(),
  );

  static final List<String> titles = [
    'dashboard.Modules'.tr(),
    'dashboard.Calendar'.tr(),
  ];

  static const List<IconData> icons = [
    Icons.workspaces_rounded,
    Icons.calendar_today_rounded,
  ];

  const HomeNavigationBar({
    Key? key,
    required this.pageController,
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

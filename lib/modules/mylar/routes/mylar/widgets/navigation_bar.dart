import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class MylarNavigationBar extends StatelessWidget {
  final PageController? pageController;
  static List<ScrollController> scrollControllers = List.generate(
    icons.length,
    (_) => ScrollController(),
  );

  static const List<IconData> icons = [
    Icons.live_tv_rounded,
    Icons.insert_invitation_rounded,
    Icons.event_busy_rounded,
    Icons.more_horiz_rounded,
  ];

  static List<String> get titles => [
        'mylar.Series'.tr(),
        'mylar.Upcoming'.tr(),
        'mylar.Missing'.tr(),
        'mylar.More'.tr(),
      ];

  const MylarNavigationBar({
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

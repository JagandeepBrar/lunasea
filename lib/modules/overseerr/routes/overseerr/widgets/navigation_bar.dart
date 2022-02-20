import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class OverseerrNavigationBar extends StatelessWidget {
  final PageController? pageController;
  static List<ScrollController> scrollControllers = List.generate(
    icons.length,
    (_) => ScrollController(),
  );

  static const List<IconData> icons = [
    LunaIcons.REQUESTS,
    LunaIcons.WARNING,
    LunaIcons.USERS,
  ];

  static List<String> get titles => [
        'overseerr.Requests'.tr(),
        'overseerr.Issues'.tr(),
        'overseerr.Users'.tr(),
      ];

  const OverseerrNavigationBar({
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

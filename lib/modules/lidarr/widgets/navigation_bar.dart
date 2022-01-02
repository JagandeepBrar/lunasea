import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LidarrNavigationBar extends StatelessWidget {
  final PageController? pageController;
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());

  static const List<IconData> icons = [
    Icons.people_rounded,
    Icons.event_busy_rounded,
    Icons.history_rounded,
  ];

  static const List<IconData> iconsOutlined = [
    Icons.people_outline_rounded,
    Icons.event_busy_outlined,
    Icons.history_outlined,
  ];

  static List<String> get titles => [
        'Artists',
        'Missing',
        'History',
      ];

  const LidarrNavigationBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomNavigationBar(
      pageController: pageController,
      scrollControllers: scrollControllers,
      icons: icons,
      iconsOutlined: iconsOutlined,
      titles: titles,
    );
  }
}

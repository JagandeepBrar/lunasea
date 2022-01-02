import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class RadarrSystemStatusNavigationBar extends StatelessWidget {
  final PageController? pageController;
  static const List<IconData> icons = [
    Icons.subject_rounded,
    Icons.health_and_safety,
    Icons.donut_large_rounded,
  ];
  static const List<String> titles = ['About', 'Health Check', 'Disk Space'];
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());

  const RadarrSystemStatusNavigationBar({
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

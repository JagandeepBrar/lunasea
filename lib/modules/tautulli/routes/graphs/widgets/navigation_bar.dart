import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliGraphsNavigationBar extends StatelessWidget {
  final PageController? pageController;
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());

  static const List<IconData> icons = [
    Icons.history_rounded,
    Icons.videocam_rounded,
  ];

  static const List<String> titles = [
    'Plays by Period',
    'Stream Information',
  ];

  const TautulliGraphsNavigationBar({
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

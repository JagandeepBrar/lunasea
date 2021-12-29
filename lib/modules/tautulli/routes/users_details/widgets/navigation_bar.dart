import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliUserDetailsNavigationBar extends StatelessWidget {
  final PageController? pageController;
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());

  static const List<IconData> icons = [
    Icons.person_rounded,
    Icons.history_rounded,
    Icons.sync_rounded,
    Icons.computer_rounded,
  ];

  static const List<String> titles = [
    'Profile',
    'History',
    'Synced',
    'IPs',
  ];

  const TautulliUserDetailsNavigationBar({
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

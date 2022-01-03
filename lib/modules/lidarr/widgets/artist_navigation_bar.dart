import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LidarrArtistNavigationBar extends StatelessWidget {
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());
  final PageController pageController;

  static const List<String> titles = [
    'Overview',
    'Albums',
  ];

  static const List<IconData> icons = [
    Icons.subject_rounded,
    Icons.my_library_music_rounded,
  ];

  const LidarrArtistNavigationBar({
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

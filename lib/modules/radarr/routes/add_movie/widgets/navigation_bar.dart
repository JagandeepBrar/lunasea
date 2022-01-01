import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class RadarrAddMovieNavigationBar extends StatelessWidget {
  final PageController? pageController;
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());

  static const List<IconData> icons = [
    Icons.search_rounded,
    Icons.whatshot_rounded,
  ];

  static const List<IconData> iconsOutlined = [
    Icons.search_outlined,
    Icons.whatshot_outlined,
  ];

  static List<String> get titles => [
        'radarr.Search'.tr(),
        'radarr.Discover'.tr(),
      ];

  const RadarrAddMovieNavigationBar({
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

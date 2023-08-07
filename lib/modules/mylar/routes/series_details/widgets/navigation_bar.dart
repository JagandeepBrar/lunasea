import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class MylarSeriesDetailsNavigationBar extends StatelessWidget {
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());

  static const List<IconData> icons = [
    Icons.subject_rounded,
    Icons.live_tv_rounded,
    Icons.history_rounded,
  ];

  static final List<String> titles = [
    'mylar.Overview'.tr(),
    'mylar.Seasons'.tr(),
    'mylar.History'.tr(),
  ];

  final PageController? pageController;

  const MylarSeriesDetailsNavigationBar({
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

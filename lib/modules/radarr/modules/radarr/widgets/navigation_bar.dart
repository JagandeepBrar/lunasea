import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class RadarrNavigationBar extends StatelessWidget {
    final PageController pageController;
    static const List<IconData> icons = [CustomIcons.movies, CustomIcons.upcoming, CustomIcons.calendar_missing, Icons.more_horiz];
    static const List<String> titles = ['Movies', 'Upcoming', 'Missing', 'More'];
    static List<ScrollController> scrollControllers = List.generate(titles.length, (_) => ScrollController());

    RadarrNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

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

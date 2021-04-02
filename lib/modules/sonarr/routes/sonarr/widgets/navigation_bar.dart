import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SonarrNavigationBar extends StatelessWidget {
    final PageController pageController;
    static List<ScrollController> scrollControllers = List.generate(icons.length, (_) => ScrollController());


    static const List<IconData> icons = [
        LunaIcons.television,
        LunaIcons.upcoming,
        LunaIcons.calendar_missing,
        LunaIcons.history,
    ];

    static const List<String> titles = [
        'Series',
        'Upcoming',
        'Missing',
        'History',
    ];

    SonarrNavigationBar({
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

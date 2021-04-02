import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SonarrSeriesDetailsNavigationBar extends StatelessWidget {
    final PageController pageController;
    static List<ScrollController> scrollControllers = List.generate(icons.length, (_) => ScrollController());

    static const List<IconData> icons = [
        Icons.subject_rounded,
        LunaIcons.television,
    ];

    static const List<String> titles = [
        'Overview',
        'Seasons',
    ];

    SonarrSeriesDetailsNavigationBar({
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

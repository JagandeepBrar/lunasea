import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class RadarrAddMovieNavigationBar extends StatelessWidget {
    final PageController pageController;
    static const List<IconData> icons = [Icons.search, Icons.whatshot];
    static const List<String> titles = ['Search', 'Discover'];
    static List<ScrollController> scrollControllers = [ScrollController(), ScrollController()];

    RadarrAddMovieNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaBottomNavigationBar(
            pageController: pageController,
            scrollControllers: scrollControllers,
            icons: RadarrAddMovieNavigationBar.icons,
            titles: RadarrAddMovieNavigationBar.titles,
        );
    }
}

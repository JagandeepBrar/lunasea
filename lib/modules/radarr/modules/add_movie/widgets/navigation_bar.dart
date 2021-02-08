import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieNavigationBar extends StatelessWidget {
    final PageController pageController;
    static const List<IconData> icons = [Icons.search, Icons.whatshot];
    static const List<String> titles = ['Search', 'Discover'];

    RadarrAddMovieNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaBottomNavigationBar(
            pageController: pageController,
            icons: RadarrAddMovieNavigationBar.icons,
            titles: RadarrAddMovieNavigationBar.titles,
            startingIndex: RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.data,
        );
    }
}

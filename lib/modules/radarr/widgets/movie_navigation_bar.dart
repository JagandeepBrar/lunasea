import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieNavigationBar extends StatefulWidget {
    final PageController pageController;

    RadarrMovieNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieNavigationBar> {
    static const List<String> _navbarTitles = [
        'Overview',
        'Search',
    ];

    static const List<IconData> _navbarIcons = [
        Icons.subject,
        CustomIcons.movies,
    ];

    @override
    Widget build(BuildContext context) => Selector<RadarrModel, int>(
        selector: (_, model) => model.movieNavigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: _navbarIcons,
            titles: _navbarTitles,
            onTap: (index) async => await _navOnTap(index),
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        ).then((_) => Provider.of<RadarrModel>(context, listen: false).movieNavigationIndex = index);
    }
}

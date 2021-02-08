import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        CustomIcons.movies,
        CustomIcons.upcoming,
        CustomIcons.calendar_missing,
        Icons.more_horiz,
    ];

    static const List<String> titles = [
        'Movies',
        'Upcoming',
        'Missing',
        'More',
    ];

    final PageController pageController;

    RadarrNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrNavigationBar> {
    int _index = RadarrDatabaseValue.NAVIGATION_INDEX.data;

    @override
    void initState() {
        super.initState();
        widget.pageController?.addListener(_pageControllerListener);
    }

    @override
    void dispose() {
        widget.pageController?.removeListener(_pageControllerListener);
        super.dispose();
    }

    void _pageControllerListener() {
        if(widget.pageController.page.round() == _index) return;
        setState(() => _index = widget.pageController.page.round());
    }

    @override
    Widget build(BuildContext context) => LSBottomNavigationBar(
        index: _index,
        onTap: _navOnTap,
        icons: RadarrNavigationBar.icons,
        titles: RadarrNavigationBar.titles,
    );

    Future<void> _navOnTap(int index) async {
        widget.pageController.lunaAnimateToPage(index);
    }
}

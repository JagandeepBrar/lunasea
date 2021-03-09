import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrNavigationBar extends StatefulWidget {
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

    final PageController pageController;

    SonarrNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrNavigationBar> {
    int _index = SonarrDatabaseValue.NAVIGATION_INDEX.data;

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
        icons: SonarrNavigationBar.icons,
        titles: SonarrNavigationBar.titles,
    );

    Future<void> _navOnTap(int index) async {
        widget.pageController.lunaAnimateToPage(index);
    }
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        Icons.subject_rounded,
        Icons.insert_drive_file_outlined,
        Icons.history,
        Icons.person,
    ];

    static const List<String> titles = [
        'Overview',
        'Files',
        'History',
        'Cast & Crew',
    ];

    final PageController pageController;

    RadarrMovieDetailsNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsNavigationBar> {
    int _index = RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.data;

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
        icons: RadarrMovieDetailsNavigationBar.icons,
        titles: RadarrMovieDetailsNavigationBar.titles,
    );

    Future<void> _navOnTap(int index) async {
        widget.pageController.lunaAnimateToPage(index);
    }
}

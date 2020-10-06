import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        Icons.subject,
        CustomIcons.television,
    ];

    static const List<String> titles = [
        'Overview',
        'Seasons',
    ];

    final PageController pageController;

    SonarrSeriesDetailsNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeriesDetailsNavigationBar> {
    int _index = SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data;

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
        icons: SonarrSeriesDetailsNavigationBar.icons,
        titles: SonarrSeriesDetailsNavigationBar.titles,
    );

    Future<void> _navOnTap(int index) async {
        if(widget.pageController.hasClients) widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
    }
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../radarr.dart';

class RadarrNavigationBar extends StatefulWidget {
    final PageController pageController;

    RadarrNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrNavigationBar> {
    static const List<String> _navbarTitles = [
        'Catalogue',
        'Upcoming',
        'Missing',
        'History',
    ];

    static const List<Icon> _navbarIcons = [
        Icon(CustomIcons.movies),
        Icon(CustomIcons.upcoming),
        Icon(CustomIcons.calendar_missing),
        Icon(CustomIcons.history),
    ];

    @override
    Widget build(BuildContext context) => Selector<RadarrModel, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: _navbarIcons,
            titles: _navbarTitles,
            onTap: _navOnTap,
        ),
    );

    void _navOnTap(int index) {
        widget.pageController.jumpToPage(index);
        Provider.of<RadarrModel>(context, listen: false).navigationIndex = index;
    }
}
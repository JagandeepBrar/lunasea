import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

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

    static const List<IconData> _navbarIcons = [
        CustomIcons.movies,
        CustomIcons.upcoming,
        CustomIcons.calendar_missing,
        CustomIcons.history,
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

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<RadarrModel>(context, listen: false).navigationIndex = index;
    }
}
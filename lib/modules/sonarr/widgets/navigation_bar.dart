import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

class SonarrNavigationBar extends StatefulWidget {
    final PageController pageController;

    SonarrNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrNavigationBar> {
    static const List<String> _navbarTitles = [
        'Catalogue',
        'Upcoming',
        'Missing',
        'History',
    ];

    static const List<IconData> _navbarIcons = [
        CustomIcons.television,
        CustomIcons.upcoming,
        CustomIcons.calendar_missing,
        CustomIcons.history,
    ];

    @override
    Widget build(BuildContext context) => Selector<SonarrModel, int>(
        selector: (_, model) => model.navigationIndex,
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
        ).then((_) => Provider.of<SonarrModel>(context, listen: false).navigationIndex = index);
    }
}
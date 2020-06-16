import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesNavigationBar extends StatefulWidget {
    final PageController pageController;

    SonarrSeriesNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeriesNavigationBar> {
    static const List<String> _navbarTitles = [
        'Overview',
        'Seasons',
    ];

    static const List<IconData> _navbarIcons = [
        Icons.subject,
        CustomIcons.television,
    ];

    @override
    Widget build(BuildContext context) => Selector<SonarrModel, int>(
        selector: (_, model) => model.seriesNavigationIndex,
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
        ).then((_) => Provider.of<SonarrModel>(context, listen: false).seriesNavigationIndex = index);
    }
}

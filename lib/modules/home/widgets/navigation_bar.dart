import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../home.dart';

class HomeNavigationBar extends StatefulWidget {
    final PageController pageController;

    HomeNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<HomeNavigationBar> {
    static const List<String> _navbarTitles = [
        'Services',
        'Calendar',
    ];

    static const List<IconData> _navbarIcons = [
        CustomIcons.home,
        CustomIcons.calendar,
    ];

    @override
    Widget build(BuildContext context) => Selector<HomeModel, int>(
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
        ).then((_) => Provider.of<HomeModel>(context, listen: false).navigationIndex = index);
    }
}
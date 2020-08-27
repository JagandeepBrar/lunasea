import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        CustomIcons.monitoring,
        CustomIcons.user,
        CustomIcons.history,
        Icons.more_horiz,
    ];

    static const List<String> titles = [
        'Activity',
        'Users',
        'History',
        'More',
    ];

    final PageController pageController;

    TautulliNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliNavigationBar> {
    @override
    Widget build(BuildContext context) => Selector<TautulliState, int>(
        selector: (_, state) => state.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: TautulliNavigationBar.icons,
            titles: TautulliNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<TautulliState>(context, listen: false).navigationIndex = index;
    }
}
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLibrariesDetailsNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        Icons.info_outline,
        Icons.people,
    ];

    static const List<String> titles = [
        'Information',
        'User Stats',
    ];

    final PageController pageController;

    TautulliLibrariesDetailsNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliLibrariesDetailsNavigationBar> {
    @override
    Widget build(BuildContext context) => Selector<TautulliLocalState, int>(
        selector: (_, state) => state.librariesDetailsNavigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: TautulliLibrariesDetailsNavigationBar.icons,
            titles: TautulliLibrariesDetailsNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<TautulliLocalState>(context, listen: false).librariesDetailsNavigationIndex = index;
    }
}
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        Icons.multiline_chart,
        Icons.queue_play_next,
    ];

    static const List<String> titles = [
        'Plays by Period',
        'Stream Information',
    ];

    final PageController pageController;

    TautulliGraphsNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliGraphsNavigationBar> {
    @override
    Widget build(BuildContext context) => Selector<TautulliLocalState, int>(
        selector: (_, state) => state.graphsNavigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: TautulliGraphsNavigationBar.icons,
            titles: TautulliGraphsNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<TautulliLocalState>(context, listen: false).graphsNavigationIndex = index;
    }
}
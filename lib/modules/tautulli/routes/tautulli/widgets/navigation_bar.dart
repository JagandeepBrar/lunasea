import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        LunaIcons.monitoring,
        LunaIcons.user,
        LunaIcons.history,
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
    int _index = TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.data;

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
    Widget build(BuildContext context) => Consumer<TautulliState>(
        builder: (context, state, _) => LSBottomNavigationBar(
            index: _index,
            onTap: _navOnTap,
            icons: TautulliNavigationBar.icons,
            titles: TautulliNavigationBar.titles,
            leadingOnGButton: [
                FutureBuilder(
                    future: state.activity,
                    builder: (BuildContext context, AsyncSnapshot<TautulliActivity> snapshot) => LunaNavigationBarBadge(
                        text: snapshot.hasData ? snapshot.data.streamCount.toString() : '?',
                        icon: TautulliNavigationBar.icons[0],
                        isActive: _index == 0,
                        showBadge: state.enabled && _index != 0 && snapshot.hasData && snapshot.data.streamCount > 0,
                    ),
                ),
                null,
                null,
                null,
            ],
        ),
    );

    Future<void> _navOnTap(int index) async {
        widget.pageController.lunaJumpToPage(index);
    }
}

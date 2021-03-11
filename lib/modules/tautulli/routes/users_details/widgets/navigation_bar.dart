import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliUserDetailsNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        LunaIcons.user,
        LunaIcons.history,
        Icons.sync,
        Icons.computer,
    ];

    static const List<String> titles = [
        'Profile',
        'History',
        'Synced',
        'IPs',
    ];

    final PageController pageController;

    TautulliUserDetailsNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliUserDetailsNavigationBar> {
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
    Widget build(BuildContext context) => LSBottomNavigationBar(
        index: _index,
        icons: TautulliUserDetailsNavigationBar.icons,
        titles: TautulliUserDetailsNavigationBar.titles,
        onTap: _navOnTap,
    );

    Future<void> _navOnTap(int index) async {
        widget.pageController.lunaJumpToPage(index);
    }
}

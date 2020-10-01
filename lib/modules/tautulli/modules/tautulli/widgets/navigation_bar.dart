import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

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
        builder: (context, state, _) => Container(
            child: SafeArea(
                top: false,
                child: Padding(
                    child: GNav(
                        gap: 8.0,
                        iconSize: 24.0,
                        padding: EdgeInsets.fromLTRB(18.0, 5.0, 12.0, 5.0),
                        duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
                        tabBackgroundColor: Theme.of(context).canvasColor,
                        activeColor: LunaColours.accent,
                        tabs: [
                            GButton(
                                icon: TautulliNavigationBar.icons[0],
                                text: TautulliNavigationBar.titles[0],
                                iconSize: 22.0,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    color: LunaColours.accent,
                                ),
                                leading: FutureBuilder(
                                    future: state.activity,
                                    builder: (BuildContext context, AsyncSnapshot<TautulliActivity> snapshot) => Badge(
                                        badgeColor: LunaColours.accent.withOpacity(0.65),
                                        elevation: 0,
                                        animationDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
                                        animationType: BadgeAnimationType.fade,
                                        shape: BadgeShape.circle,
                                        position: BadgePosition.topEnd(
                                            top: -15,
                                            end: -15,
                                        ),
                                        badgeContent: Text(
                                            snapshot.hasData
                                                ? snapshot.data.streamCount.toString()
                                                : '?',
                                            style: TextStyle(color: Colors.white),
                                        ),
                                        child: Icon(
                                            TautulliNavigationBar.icons[0],
                                            color: _index == 0
                                                ? LunaColours.accent
                                                : Colors.white,
                                        ),
                                        showBadge: state.enabled && _index != 0 && snapshot.hasData && snapshot.data.streamCount > 0,
                                    ),
                                ),
                            ),
                            GButton(
                                icon: TautulliNavigationBar.icons[1],
                                text: TautulliNavigationBar.titles[1],
                                iconSize: 22.0,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    color: LunaColours.accent,
                                ),
                            ),
                            GButton(
                                icon: TautulliNavigationBar.icons[2],
                                text: TautulliNavigationBar.titles[2],
                                iconSize: 22.0,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    color: LunaColours.accent,
                                ),
                            ),
                            GButton(
                                icon: TautulliNavigationBar.icons[3],
                                text: TautulliNavigationBar.titles[3],
                                iconSize: 22.0,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    color: LunaColours.accent,
                                ),
                            ),
                        ],
                        selectedIndex: _index,
                        onTabChange: _navOnTap,
                    ),
                    padding: EdgeInsets.all(12.0),
                ),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                //LunaColours.secondary,
            ),
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
    }
}

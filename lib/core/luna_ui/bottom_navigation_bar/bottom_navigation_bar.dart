import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaBottomNavigationBar extends StatefulWidget {
    final PageController pageController;
    final List<IconData> icons;
    final List<String> titles;
    final List<ScrollController> scrollControllers;
    final Function(int) onTabChange;
    final List<Widget> leadingOnTab;

    LunaBottomNavigationBar({
        Key key,
        @required this.pageController,
        @required this.icons,
        @required this.titles,
        this.onTabChange,
        this.leadingOnTab,
        this.scrollControllers,
    }) : super(key: key) {
        assert(icons.length == titles.length, 'An unequal amount of titles and icons were passed to LunaNavigationBar.');
        if(leadingOnTab != null) assert(icons.length == leadingOnTab.length, 'An unequal amount of icons and leadingOnTab were passed to LunaNavigationBar.');
        if(scrollControllers != null) assert(icons.length == scrollControllers.length, 'An unequal amount of icons and scrollControllers were passed to LunaNavigationBar.');
    }

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaBottomNavigationBar> {
    int _index;

    @override
    void initState() {
        _index = widget.pageController.initialPage;
        widget.pageController?.addListener(_pageControllerListener);
        super.initState();
    }

    @override
    void dispose() {
        widget.pageController?.removeListener(_pageControllerListener);
        super.dispose();
    }

    void _pageControllerListener() {
        if((widget.pageController?.page?.round() ?? _index) == _index) return;
        setState(() => _index = widget.pageController.page.round());
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            child: SafeArea(
                child: Padding(
                    child: GNav(
                        gap: 8.0,
                        iconSize: 24.0,
                        padding: EdgeInsets.fromLTRB(18.0, 10.0, 12.0, 10.0),
                        duration: Duration(milliseconds: LunaUI().animationUISpeed),
                        tabBackgroundColor: Theme.of(context).canvasColor,
                        activeColor: LunaColours.accent,
                        tabs: List.generate(widget.icons.length, (index) => GButton(
                            icon: widget.icons[index],
                            text: widget.titles[index],
                            iconSize: 22.0,
                            haptic: true,
                            iconColor: Colors.white,
                            textStyle: TextStyle(
                                fontWeight: LunaUI().fontWeightBold,
                                fontSize: LunaUI().fontSizeNavigationBar,
                                color: LunaColours.accent,
                            ),
                            leading: widget.leadingOnTab == null ? null : widget.leadingOnTab[index],
                        )).toList(),
                        tabActiveBorder: LunaUI().shouldUseBorder() ? Border.all(color: Colors.white12) : null,
                        selectedIndex: _index,
                        onTabChange: (index) {
                            _onTabChange(index);
                            if(widget.onTabChange != null) widget.onTabChange(index);
                        },
                    ),
                    padding: EdgeInsets.all(12.0),
                ),
                top: false,
            ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        );
    }

    void _onTabChange(int index) {
        if(index == _index) {
            if(widget.scrollControllers != null && widget.scrollControllers[index] != null) widget.scrollControllers[index].lunaAnimateToStart();
        } else {
            widget.pageController.lunaAnimateToPage(index);
        }
    }
}

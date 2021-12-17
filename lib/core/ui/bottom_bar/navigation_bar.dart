import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lunasea/core.dart';

class LunaBottomNavigationBar extends StatefulWidget {
  final PageController pageController;
  final List<IconData> icons;
  final List<String> titles;
  final List<ScrollController> scrollControllers;
  final List<Widget> topActions;
  final Function(int) onTabChange;
  final List<Widget> leadingOnTab;

  LunaBottomNavigationBar({
    Key key,
    @required this.pageController,
    @required this.icons,
    @required this.titles,
    this.topActions,
    this.onTabChange,
    this.leadingOnTab,
    this.scrollControllers,
  }) : super(key: key) {
    assert(
      icons.length == titles.length,
      'An unequal amount of titles and icons were passed to LunaNavigationBar.',
    );
    if (leadingOnTab != null) {
      assert(
        icons.length == leadingOnTab.length,
        'An unequal amount of icons and leadingOnTab were passed to LunaNavigationBar.',
      );
    }
    if (scrollControllers != null) {
      assert(
        icons.length == scrollControllers.length,
        'An unequal amount of icons and scrollControllers were passed to LunaNavigationBar.',
      );
    }
  }

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaBottomNavigationBar> {
  int _index;

  @override
  void initState() {
    _index = widget.pageController?.initialPage ?? 0;
    widget.pageController?.addListener(_pageControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController?.removeListener(_pageControllerListener);
    super.dispose();
  }

  void _pageControllerListener() {
    if ((widget.pageController?.page?.round() ?? _index) == _index) return;
    setState(() => _index = widget.pageController.page.round());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if ((widget.topActions?.length ?? 0) != 0)
            LunaBottomActionBar(
              actions: widget.topActions,
              useSafeArea: false,
            ),
          SafeArea(
            child: Padding(
              child: GNav(
                gap: 8.0,
                duration: const Duration(milliseconds: LunaUI.ANIMATION_SPEED),
                tabBackgroundColor: Theme.of(context)
                    .canvasColor
                    .withOpacity(LunaUI.OPACITY_BUTTON_BACKGROUND),
                activeColor: LunaColours.accent,
                tabs: List.generate(
                    widget.icons.length,
                    (index) => GButton(
                          icon: widget.icons[index],
                          text: widget.titles[index],
                          active: _index == index,
                          iconSize: LunaUI.ICON_SIZE_DEFAULT,
                          haptic: true,
                          padding: _index == index
                              ? const EdgeInsets.all(10.0)
                                  .add(const EdgeInsets.only(left: 6.0))
                              : const EdgeInsets.all(10.0),
                          iconColor: Colors.white,
                          textStyle: const TextStyle(
                            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                            fontSize: LunaUI.FONT_SIZE_H3,
                            color: Colors.white,
                          ),
                          iconActiveColor: LunaColours.accent,
                          leading: widget.leadingOnTab == null
                              ? null
                              : widget.leadingOnTab[index],
                        )).toList(),
                tabActiveBorder: LunaUI.shouldUseBorder
                    ? Border.all(color: Colors.white12)
                    : null,
                tabBorder: LunaUI.shouldUseBorder
                    ? Border.all(color: Colors.transparent)
                    : null,
                selectedIndex: _index,
                onTabChange: (index) {
                  _onTabChange(index);
                  if (widget.onTabChange != null) widget.onTabChange(index);
                },
              ),
              padding: (widget.topActions?.isNotEmpty ?? false)
                  ? const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0)
                  : const EdgeInsets.all(12.0),
            ),
            top: false,
          ),
        ],
      ),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    );
  }

  void _onTabChange(int index) {
    if (index == _index) {
      if (widget.scrollControllers != null &&
          widget.scrollControllers[index] != null)
        widget.scrollControllers[index].lunaAnimateToStart();
    } else {
      widget.pageController.lunaJumpToPage(index);
    }
  }
}

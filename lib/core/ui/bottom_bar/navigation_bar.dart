import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaBottomNavigationBar extends StatefulWidget {
  final PageController? pageController;
  final List<IconData> icons;
  final List<String> titles;
  final List<ScrollController>? scrollControllers;
  final List<Widget>? topActions;
  final ValueChanged<int>? onTabChange;
  final List<Widget?>? leadingOnTab;

  LunaBottomNavigationBar({
    Key? key,
    required this.pageController,
    required this.icons,
    required this.titles,
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
        icons.length == leadingOnTab!.length,
        'An unequal amount of icons and leadingOnTab were passed to LunaNavigationBar.',
      );
    }
    if (scrollControllers != null) {
      assert(
        icons.length == scrollControllers!.length,
        'An unequal amount of icons and scrollControllers were passed to LunaNavigationBar.',
      );
    }
  }

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaBottomNavigationBar> {
  late int _index;

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
    if ((widget.pageController!.page?.round() ?? _index) == _index) return;
    setState(() => _index = widget.pageController!.page!.round());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.topActions?.isNotEmpty ?? false)
          LunaBottomActionBar(
            actions: widget.topActions,
            useSafeArea: false,
            padding: LunaUI.MARGIN_HALF.copyWith(bottom: 0.0),
          ),
        Container(
          child: Theme(
            // https://m3.material.io/components/navigation-bar/specs
            data: ThemeData(
              useMaterial3: true,
              navigationBarTheme: NavigationBarThemeData(
                backgroundColor: Colors.transparent,
                indicatorColor: Theme.of(context).canvasColor,
                iconTheme: MaterialStateProperty.all(const IconThemeData(
                  color: LunaColours.white,
                )),
                // Label medium
                labelTextStyle: MaterialStateProperty.all(
                  const LunaTextStyle.labelMedium().copyWith(
                    color: LunaColours.white,
                  ),
                ),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              ),
              splashColor: Theme.of(context).splashColor,
              tooltipTheme: Theme.of(context).tooltipTheme,
            ),
            child: NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: (idx) => _onDestinationSelected(idx),
              destinations: List.generate(
                widget.titles.length,
                (idx) => NavigationDestination(
                  label: widget.titles[idx],
                  icon: widget.leadingOnTab?.elementAtOrNull(idx) ??
                      Icon(widget.icons[idx]),
                  selectedIcon: Icon(
                    widget.icons[idx],
                    color: LunaColours.accent,
                  ),
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        )
      ],
    );
  }

  void _onDestinationSelected(int idx) {
    HapticFeedback.mediumImpact();
    if (idx == _index && widget.scrollControllers != null) {
      widget.scrollControllers![idx].lunaAnimateToStart();
    } else if (widget.pageController != null) {
      widget.pageController!.lunaJumpToPage(idx);
    }
    if (widget.onTabChange != null) widget.onTabChange!(idx);
    setState(() => _index = idx);
  }
}

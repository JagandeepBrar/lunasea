import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliNavigationBar extends StatefulWidget {
  final PageController? pageController;
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());

  static const List<IconData> icons = [
    Icons.timelapse_rounded,
    Icons.person_rounded,
    Icons.history_rounded,
    Icons.more_horiz_rounded,
  ];

  static List<String> get titles => [
        'tautulli.Activity'.tr(),
        'tautulli.Users'.tr(),
        'tautulli.History'.tr(),
        'tautulli.More'.tr(),
      ];

  const TautulliNavigationBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliNavigationBar> {
  int? _index;

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
    setState(() => _index = widget.pageController!.page!.round());
  }

  @override
  Widget build(BuildContext context) {
    return LunaBottomNavigationBar(
      pageController: widget.pageController,
      scrollControllers: TautulliNavigationBar.scrollControllers,
      icons: TautulliNavigationBar.icons,
      titles: TautulliNavigationBar.titles,
      leadingOnTab: [
        FutureBuilder(
          future: context.watch<TautulliState>().activity,
          builder: (BuildContext context,
                  AsyncSnapshot<TautulliActivity?> snapshot) =>
              LunaNavigationBarBadge(
            text:
                snapshot.hasData ? snapshot.data!.streamCount.toString() : '?',
            icon: TautulliNavigationBar.icons[0],
            isActive: _index == 0,
            showBadge: context.read<TautulliState>().enabled &&
                _index != 0 &&
                snapshot.hasData &&
                snapshot.data!.streamCount! > 0,
          ),
        ),
        null,
        null,
        null,
      ],
    );
  }
}

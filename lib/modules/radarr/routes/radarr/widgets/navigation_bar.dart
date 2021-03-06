import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class RadarrNavigationBar extends StatelessWidget {
    final PageController pageController;
    static List<ScrollController> scrollControllers = List.generate(icons.length, (_) => ScrollController());

    static const List<IconData> icons = [
        CustomIcons.movies,
        CustomIcons.upcoming,
        CustomIcons.calendar_missing,
        Icons.more_horiz,
    ];

    static List<String> get titles => [
        'radarr.Movies'.tr(),
        'radarr.Upcoming'.tr(),
        'radarr.Missing'.tr(),
        'More',
    ];

    RadarrNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaBottomNavigationBar(
            pageController: pageController,
            scrollControllers: scrollControllers,
            icons: icons,
            titles: titles,
        );
    }
}

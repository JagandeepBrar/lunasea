import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LidarrNavigationBar extends StatelessWidget {
    final PageController pageController;
    static List<ScrollController> scrollControllers = List.generate(icons.length, (_) => ScrollController());
    
    static const List<IconData> icons = [
        LunaIcons.music,
        LunaIcons.calendar_missing,
        LunaIcons.history,
    ];

    static List<String> get titles => [
        'Artists',
        'Missing',
        'History',
    ];

    LidarrNavigationBar({
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

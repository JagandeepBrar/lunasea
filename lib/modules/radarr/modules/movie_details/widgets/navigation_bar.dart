import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class RadarrMovieDetailsNavigationBar extends StatelessWidget {
    static const List<IconData> icons = [Icons.subject_rounded, Icons.insert_drive_file_outlined, Icons.history, Icons.person];
    static const List<String> titles = ['Overview', 'Files', 'History', 'Cast & Crew'];
    static List<ScrollController> scrollControllers = List.generate(icons.length, (_) => ScrollController());
    final PageController pageController;

    RadarrMovieDetailsNavigationBar({
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

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../lidarr.dart';

class LidarrNavigationBar extends StatefulWidget {
    final PageController pageController;

    LidarrNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LidarrNavigationBar> {
    static const List<Icon> _navbarIcons = [
        Icon(CustomIcons.music),
        Icon(CustomIcons.calendar_missing),
        Icon(CustomIcons.history)
    ];

    static const List<String> _navbarTitles = [
        'Catalogue',
        'Missing',
        'History',
    ];

    @override
    Widget build(BuildContext context) => Selector<LidarrModel, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: _navbarIcons,
            titles: _navbarTitles,
            onTap: _navOnTap,
        ),
    );

    void _navOnTap(int index) {
        widget.pageController.jumpToPage(index);
        Provider.of<LidarrModel>(context, listen: false).navigationIndex = index;
    }
}
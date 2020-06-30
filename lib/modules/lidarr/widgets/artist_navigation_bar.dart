import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrArtistNavigationBar extends StatefulWidget {
    final PageController pageController;

    LidarrArtistNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LidarrArtistNavigationBar> {
    static const List<String> _navbarTitles = [
        'Overview',
        'Albums',
    ];

    static const List<IconData> _navbarIcons = [
        Icons.subject,
        CustomIcons.music,
    ];

    @override
    Widget build(BuildContext context) => Selector<LidarrModel, int>(
        selector: (_, model) => model.artistNavigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: _navbarIcons,
            titles: _navbarTitles,
            onTap: (index) async => await _navOnTap(index),
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        ).then((_) => Provider.of<LidarrModel>(context, listen: false).artistNavigationIndex = index);
    }
}

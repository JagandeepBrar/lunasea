import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class HomeNavigationBar extends StatefulWidget {
    static const List<String> titles = [
        'Modules',
        'Calendar',
    ];

    static const List<IconData> icons = [
        CustomIcons.modules,
        CustomIcons.calendar,
    ];

    final PageController pageController;

    HomeNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<HomeNavigationBar> {
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            Provider.of<HomeState>(context, listen: false).navigationIndex = HomeDatabaseValue.NAVIGATION_INDEX.data;
        });
    }

    @override
    Widget build(BuildContext context) => Selector<HomeState, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: HomeNavigationBar.icons,
            titles: HomeNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        widget.pageController.lunaAnimateToPage(index)
        .then((_) => Provider.of<HomeState>(context, listen: false).navigationIndex = index);
    }
}
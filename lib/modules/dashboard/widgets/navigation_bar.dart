import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';

class DashboardNavigationBar extends StatefulWidget {
    static const List<String> titles = [
        'Modules',
        'Calendar',
    ];

    static const List<IconData> icons = [
        LunaIcons.modules,
        LunaIcons.calendar,
    ];

    final PageController pageController;

    DashboardNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<DashboardNavigationBar> {
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            Provider.of<DashboardState>(context, listen: false).navigationIndex = DashboardDatabaseValue.NAVIGATION_INDEX.data;
        });
    }

    @override
    Widget build(BuildContext context) => Selector<DashboardState, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: DashboardNavigationBar.icons,
            titles: DashboardNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        widget.pageController.lunaAnimateToPage(index)
        .then((_) => Provider.of<DashboardState>(context, listen: false).navigationIndex = index);
    }
}
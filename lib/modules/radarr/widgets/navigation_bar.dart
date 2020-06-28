import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrNavigationBar extends StatefulWidget {
    static const List<String> titles = [
        'Catalogue',
        'Upcoming',
        'Missing',
        'History',
    ];

    static const List<IconData> icons = [
        CustomIcons.movies,
        CustomIcons.upcoming,
        CustomIcons.calendar_missing,
        CustomIcons.history,
    ];

    final PageController pageController;

    RadarrNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrNavigationBar> {
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            Provider.of<RadarrModel>(context, listen: false).navigationIndex = RadarrDatabaseValue.NAVIGATION_INDEX.data;
        });
    }

    @override
    Widget build(BuildContext context) => Selector<RadarrModel, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: RadarrNavigationBar.icons,
            titles: RadarrNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<RadarrModel>(context, listen: false).navigationIndex = index;
    }
}
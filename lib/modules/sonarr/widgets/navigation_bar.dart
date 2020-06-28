import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrNavigationBar extends StatefulWidget {
    static const List<String> titles = [
        'Catalogue',
        'Upcoming',
        'Missing',
        'History',
    ];

    static const List<IconData> icons = [
        CustomIcons.television,
        CustomIcons.upcoming,
        CustomIcons.calendar_missing,
        CustomIcons.history,
    ];

    final PageController pageController;

    SonarrNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrNavigationBar> {
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            Provider.of<SonarrModel>(context, listen: false).navigationIndex = SonarrDatabaseValue.NAVIGATION_INDEX.data;
        });
    }

    @override
    Widget build(BuildContext context) => Selector<SonarrModel, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: SonarrNavigationBar.icons,
            titles: SonarrNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        ).then((_) => Provider.of<SonarrModel>(context, listen: false).navigationIndex = index);
    }
}